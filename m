Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbSI3Tj5>; Mon, 30 Sep 2002 15:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261276AbSI3Tj5>; Mon, 30 Sep 2002 15:39:57 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:13700 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261246AbSI3Tj4>;
	Mon, 30 Sep 2002 15:39:56 -0400
Date: Mon, 30 Sep 2002 14:45:13 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Felipe Alfaro Solana <felipe_alfaro@msn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord, IDE-SCSI and 2.5.39
In-Reply-To: <F758Ts6DdVjkfQWswop000122ba@hotmail.com>
Message-ID: <Pine.LNX.4.44.0209301443230.3692-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2002, Felipe Alfaro Solana wrote:

> Hello,
> 
> I have found that cdrecord 1.11a34 has stopped working on linux kernel 
> 2.5.38+. I have a SONY CRX185E3 ATAPI burner and it works fine on 2.4.19 
> using "hdd=ide-scsi" kernel parameter, but with kernel 2.5.38+, cdrecord 
> fails when trying to access the "/dev/pg*" device files. When I run cdrecord 
> -scanbus, it complains with:
> 
> cdrecord: No such file or directory. Cannot open '/dev/pg*'. Cannot open 
> SCSI driver.

I'm using the cdrecord included in RedHat 7.3 (1.10) with no problems.  My 
cd burner is being seen at /dev/scd0

