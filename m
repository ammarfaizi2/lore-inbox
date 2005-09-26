Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbVIZJtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbVIZJtx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 05:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbVIZJtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 05:49:53 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:57245 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751623AbVIZJtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 05:49:52 -0400
Subject: Re: Kernel Compilation Question
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Woody.Wu" <Woody.Wu@cn.landisgyr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7567C3A4682B894C99E5E16494442680010AD310@cnzhuex01.cn.landisgyr.com>
References: <7567C3A4682B894C99E5E16494442680010AD310@cnzhuex01.cn.landisgyr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Sep 2005 11:16:50 +0100
Message-Id: <1127729811.26820.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-09-26 at 09:00 +0200, Woody.Wu wrote:
> and think i can build a kernel in another newer system (a slackware
> running 2.6.x) and copy needed stuff over to the old box.  is it
> possible?  if so, what stuff i have to copy from the newer box to the
> old box? what i can imaged by far are: the bzImage file, the


Possible but there is so much stuff that has changed (and 6.x has no
updates any more for security fixes).

I do a series of CD updates from 6.2 to 7.3, then 7.3 to 9 then 9 to
Fedora Core 2, and FC2 to FC3 - If I had to do it that way. But really
it'll be quicker to back it up reinstall and restore
users/config/filestore

