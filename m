Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270480AbTG1Tdk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 15:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270479AbTG1Tdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 15:33:39 -0400
Received: from windsormachine.com ([206.48.122.28]:57354 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S270489AbTG1TdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 15:33:02 -0400
Date: Mon, 28 Jul 2003 15:32:57 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: linux-kernel@vger.kernel.org
Subject: RE: DMA not supported with Intel ICH4 I/O controller?
In-Reply-To: <PMEMILJKPKGMMELCJCIGEEIKCDAA.kfrazier@mdc-dayton.com>
Message-ID: <Pine.LNX.4.56.0307281532230.12115@router.windsormachine.com>
References: <PMEMILJKPKGMMELCJCIGEEIKCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Kathy Frazier wrote:

> I checked the results of the hdparm on my system and it shows that hda has
> DMA on . . .  Hmmm. I have seen a lot of rumblings concerning DMA and IDE
> devices in the archives of this mailing list.  Is it possible that the ide
> drivers now set up the hardware correctly for the DMA?  But somehow the O/S
> does not support ICH4 for other DMA devices?
>
> Kathy
>
Ok, what is the DMA device?  Hard drive?  Can you give details?

Mike
