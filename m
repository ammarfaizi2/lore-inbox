Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbUBVO2O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 09:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbUBVO2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 09:28:14 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:29449 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S261335AbUBVO2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 09:28:13 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: make help ARCH=xx fun
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20040222095021.GB2266@mars.ravnborg.org> (Sam Ravnborg's
 message of "Sun, 22 Feb 2004 10:50:21 +0100")
References: <m3y8qwv78e.fsf@lugabout.jhcloos.org>
	<20040222095021.GB2266@mars.ravnborg.org>
Date: Sun, 22 Feb 2004 09:28:04 -0500
Message-ID: <m3ishzqjd7.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Sam" == Sam Ravnborg <sam@ravnborg.org> writes:

Sam> The sh people have decided to create the list based on the
Sam> content of the directory.  Therefore you see the SCCS entry,

I thought that went w/o saying....

The points were that if doing a readdir(3) in the tree for config
files, it would not be a bad idea to ignore directories and that
each arch should have arch-specific make help support (the cited
example was that ppc64 lacked it even though ppc had some).

-JimC

