Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWDNV7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWDNV7b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWDNV7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:59:31 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:56031 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030198AbWDNV7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:59:30 -0400
Date: Fri, 14 Apr 2006 23:59:30 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Gyorgy Szekely <hoditohod@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ramdisk driver strange behaviour
In-Reply-To: <940be6070604140659q31c45599wf729a47ef25103ee@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0604142358470.4238@yvahk01.tjqt.qr>
References: <940be6070604140659q31c45599wf729a47ef25103ee@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>mkfs.ext2 /dev/ram0     ~runs fine, no errors
>mount /dev/ram0 /mnt/disk    ~doesn't mount the filesystem, can't find
>it on device
>mkfs.ext2 /dev/ram0     ~runs fine, same as above
>mount /dev/ram0 /mnt/disk    ~mounts fine
>
Is ramdisk and ext2/ext3 compiled in, or as a module?


Jan Engelhardt
-- 
