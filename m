Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbULUSAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbULUSAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 13:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbULUSAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 13:00:20 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:51658 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261821AbULUSAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 13:00:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Nhk7NHVw/PZj7X5LDVaEh0J0Rcz6TmDXIRulQFQ/TyhNKs9h/hdDiO6a+1i6Xa+xKiayXjHwkLNr3LfpUhfRO1zyejzMbq53qFvTaYple2mBt2IW+fV8WcKGTk3Efs1noGdXj0dxpPSfpGUj9SvjA/UU334Oobvokw6t0QTkI9w=
Message-ID: <7ac1e90c04122110004bd9f3b2@mail.gmail.com>
Date: Tue, 21 Dec 2004 18:00:15 +0000
From: Bahadir Balban <bahadir.balban@gmail.com>
Reply-To: Bahadir Balban <bahadir.balban@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Re : Re: Error - Kernel panic - not syncing:VFS:unable to mount root fs on unknown block (0,0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your bootloader is cannot find your root partition. Check your
grub.conf file if you're using grub. This is off topic and you should
seek help somewhere else.

Bahadir


> I installed the latest stable 2.6.9 kernel in my 
> system. When I rebooted the system with the kernel it 
> showed the following error. 
>
>    "Kernel panic - not syncing:VFS:unable to mount 
> root fs on unknown block (3,1)" 

Thanks, 
selva
