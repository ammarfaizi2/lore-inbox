Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282128AbRKWMrh>; Fri, 23 Nov 2001 07:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282136AbRKWMr2>; Fri, 23 Nov 2001 07:47:28 -0500
Received: from ns.krot.org ([193.212.103.165]:36115 "HELO ns.krot.org")
	by vger.kernel.org with SMTP id <S282128AbRKWMrX> convert rfc822-to-8bit;
	Fri, 23 Nov 2001 07:47:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: linux-kernel@vger.kernel.org
Subject: /proc/sys/vm/(max|min)-readahead question
Date: Fri, 23 Nov 2001 13:49:03 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011123124724Z282128-17408+17814@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I'm currently using 2.4.13-ac5+tux with the /proc/sys/vm/(max|min)-readahead 
extension. Are there any plans to include this in the linus tree on 2.4, or 
should I just modify include/linux/blkdev.h and recompile?

roy
-- 
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.
