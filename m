Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVCLTDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVCLTDg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 14:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVCLTDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 14:03:36 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:19144 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261997AbVCLTDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 14:03:34 -0500
Date: Sat, 12 Mar 2005 14:03:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Guido Villa <piribillo@yahoo.it>
Cc: Manuel Lauss <mano@roarinelk.homelinux.net>, linux-kernel@vger.kernel.org
Subject: Re: Error with Sil3112A SATA controller and Maxtor 300GB HDD
Message-ID: <20050312190321.GA7366@havoc.gtf.org>
References: <20050312160704.22527.qmail@gg.mine.nu> <4233254F.3000509@roarinelk.homelinux.net> <20050312185506.29733.qmail@gg.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050312185506.29733.qmail@gg.mine.nu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 07:55:06PM +0100, Guido Villa wrote:
> Hi Manuel, 
> 
> Manuel Lauss writes: 
> 
> >I happen to have a SiI 3112A controller and a Maxtor 6B300S0 attached to
> >it, formatted with ext2. Never had any problems. I just copied
> >200GB of data to it, worked flawlessly. (Vanilla 2.6.11)
> >Maybe its the Motherboard?
> 
> so it must be the hardware.
> Thank you very much for your reply, I will check more thoroughly disk, 
> controller and mainboard. 
> 
> I am really sorry for having posted such a problem on this ml, but I was 
> quite sure it was a software problem. 

Make sure to upgrade your BIOS, too.

	Jeff



