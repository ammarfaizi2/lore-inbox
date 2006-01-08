Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWAHLsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWAHLsj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 06:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWAHLsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 06:48:39 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:61646 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751110AbWAHLsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 06:48:39 -0500
Date: Sun, 8 Jan 2006 12:48:03 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: Adrian Bunk <bunk@stusta.de>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-git2: CONFIGFS_FS shows up as M/y choice, help says "if
 unsure, say N"
In-Reply-To: <20060108021630.GA3771@kroah.com>
Message-ID: <Pine.LNX.4.61.0601081247150.30148@yvahk01.tjqt.qr>
References: <5a4c581d0601061310j3f4eb310o1d68c0b87c278685@mail.gmail.com>
 <20060106223032.GZ18439@ca-server1.us.oracle.com> <20060107220959.GA3774@stusta.de>
 <20060108021630.GA3771@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Why is CONFIGFS_FS a user-visible option?
>
>I think it should be the same as SYSFS, only changable from the EMBEDDED
>portion.
>
At its present state, no distribution uses configfs afaik, so I'd love to 
have that turned off to not enlarge the kernel binary unnecessary.


Jan Engelhardt
-- 
