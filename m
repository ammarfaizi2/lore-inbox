Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWBZT45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWBZT45 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 14:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWBZT45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 14:56:57 -0500
Received: from mail.gatrixx.com ([217.111.11.44]:1197 "EHLO mail.gatrixx.com")
	by vger.kernel.org with ESMTP id S1751398AbWBZT44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 14:56:56 -0500
Date: Sun, 26 Feb 2006 20:56:54 +0100 (CET)
From: Oliver Joa <oliver@j-o-a.de>
X-X-Sender: olli@majestix.gallier.de
To: Milan Kupcevic <milan@physics.harvard.edu>
cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
       torvalds@osdl.org
Subject: Re: [PATCH] sata_promise: Port enumeration order - SATA 150 TX4,
 SATA 300 TX4 
In-Reply-To: <43FFAE3D.7010002@physics.harvard.edu>
Message-ID: <Pine.LNX.4.63.0602262056120.2664@majestix.gallier.de>
References: <43FFAE3D.7010002@physics.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 24 Feb 2006, Milan Kupcevic wrote:

> From: Milan Kupcevic <milan@physics.harvard.edu>
>
> Fix Promise SATAII 150 TX4 (PDC40518) and Promise SATA 300 TX4 (PDC40718-GP) 
> wrong port enumeration order that makes it (nearly) impossible to deal with 
> boot problems using two or more drives.


I wonder that a lot of people use promise sata 300 tx4. i have lots of
problems, i always get scsi-errors. now i changed to other harddisk. i use
seagate, which is on the compatibility-list of this card. so why is it not
working in my computer. i use kernel 2.6.15. what else can be wrong? I 
have a
intel serverboard with dual p3 with 440gx-chipset.

The driver from promise does not compile. Someone out there who got it 
running?
What to do?

any idea?

Thank you very much.

Olli
