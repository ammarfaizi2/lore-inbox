Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268809AbRHFPcP>; Mon, 6 Aug 2001 11:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268824AbRHFPcG>; Mon, 6 Aug 2001 11:32:06 -0400
Received: from c1355221-a.palto1.sfba.home.com ([65.11.101.130]:5119 "HELO
	knave.rad.directint.net") by vger.kernel.org with SMTP
	id <S268809AbRHFPbu>; Mon, 6 Aug 2001 11:31:50 -0400
To: linux-kernel@vger.kernel.org
Subject: looking for resources for designing loopback filesystem
From: dave-mlist@bfnet.com
Date: 06 Aug 2001 08:23:47 -0700
In-Reply-To: <5.1.0.14.2.20010803232810.0415b840@pop.cus.cam.ac.uk>
Message-ID: <ygehevl5i0s.fsf_-_@bfnet.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to create a filesystem which mirrors another local
filesystem, but with different permissions, and with some content
invisible to some users.  Is there a kernel module that does this
already?  Is the loopback module the one?  If so, where can I learn
about applying the module to this purpose?

Dave
