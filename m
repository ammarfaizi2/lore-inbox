Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267115AbTAUQJ5>; Tue, 21 Jan 2003 11:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbTAUQJ5>; Tue, 21 Jan 2003 11:09:57 -0500
Received: from havoc.daloft.com ([64.213.145.173]:60578 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267115AbTAUQJ4>;
	Tue, 21 Jan 2003 11:09:56 -0500
Date: Tue, 21 Jan 2003 11:18:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "Matthew D. Pitts" <mpitts@suite224.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NForce Chipset support in which kernels?
Message-ID: <20030121161857.GA2139@gtf.org>
References: <3E287188.9030909@hanaden.com> <1043052878.12182.26.camel@dhcp22.swansea.linux.org.uk> <001d01c2c161$90449f40$0100a8c0@pcs686>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001d01c2c161$90449f40$0100a8c0@pcs686>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 10:24:13AM -0500, Matthew D. Pitts wrote:
> Unless you get the drivers from nVIDIA website.

Note that the nVidia NIC driver, at least, continues to have open
reports of crashing net drivers that get reported to me :/  Since
nVidia will not provide documentation, who knows if this will ever
get fixed.

I would recommend sticking a 3rd party NIC in the board, and avoiding
the nVidia on-board NIC like the plague.

It is also worth noting that many nForce boards come with 8139
on-board.  I guess some board makers don't trust the nVidia NIC
hardware either...

	Jeff



