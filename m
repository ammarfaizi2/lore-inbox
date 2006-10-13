Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422830AbWJNTIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422830AbWJNTIE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 15:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422824AbWJNTID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 15:08:03 -0400
Received: from natreg.rzone.de ([81.169.145.183]:7904 "EHLO natreg.rzone.de")
	by vger.kernel.org with ESMTP id S1422826AbWJNTIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 15:08:01 -0400
Date: Fri, 13 Oct 2006 20:37:20 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.19-rc2
Message-ID: <20061013183720.GA4718@aepfle.de>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, Linus Torvalds wrote:

> 
> Ok, it's a week since -rc1, so -rc2 is out there.

The tar.gz is broken:
tar tvfz /mounts/mirror/kernel/v2.6/testing/linux-2.6.19-rc2.tar.gz| head
-rw-r--r-- git/git         542 2006-10-13 18:25:04 linux-2.6.19-rc2.gitignore
-rw-r--r-- git/git       18693 2006-10-13 18:25:04 linux-2.6.19-rc2COPYING
-rw-r--r-- git/git       90289 2006-10-13 18:25:04 linux-2.6.19-rc2CREDITS

