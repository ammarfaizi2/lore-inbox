Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVBJXDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVBJXDw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 18:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVBJXDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 18:03:52 -0500
Received: from [212.29.226.3] ([212.29.226.3]:5588 "HELO arava.co.il")
	by vger.kernel.org with SMTP id S261882AbVBJXDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 18:03:51 -0500
Date: Fri, 11 Feb 2005 01:03:47 +0200 (IST)
From: Matan Ziv-Av <matan@svgalib.org>
X-X-Sender: matan@matan.home
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI]   Samsung
 P35, S3, black screen (radeon))
In-Reply-To: <420BB267.8060108@tmr.com>
Message-ID: <Pine.LNX.4.61.0502110058230.9595@matan.home>
References: <20050205093550.GC1158@elf.ucw.cz><e796392205020221387d4d8562@mail.gmail.com>
 <1107695583.14847.167.camel@localhost.localdomain> <420BB267.8060108@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005, Bill Davidsen wrote:

>> Some systems (intel notably) appear to expect you to use the bios
>> save/restore video state not re-POST.
>
> Isn't that what it's there for? In any context other than save/restore I 
> wouldn't think using the BIOS was a good approach. But this is a special 
> case, and if there's a BIOS function which does the right thing, it would 
> seem to be easier to assume that the BIOS works than that the driver can do 
> every operation for a clean restart.

Maybe with new cards it is different but a few years ago, most cards 
that I tested had problems with those functions.


-- 
Matan Ziv-Av.                         matan@svgalib.org

