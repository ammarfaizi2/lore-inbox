Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262145AbSJVWzx>; Tue, 22 Oct 2002 18:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262187AbSJVWzw>; Tue, 22 Oct 2002 18:55:52 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:31931 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262145AbSJVWzv>; Tue, 22 Oct 2002 18:55:51 -0400
Subject: Re: CS4236B stopping working as of 2.5.44
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Burton Windle <bwindle@fint.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.43.0210221733150.3106-100000@morpheus>
References: <Pine.LNX.4.43.0210221733150.3106-100000@morpheus>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 00:18:19 +0100
Message-Id: <1035328699.31873.189.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 22:45, Burton Windle wrote:
> With 2.5.44:
> PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe2f4, dseg 0x40
> pnp: pnp: match found with the PnP device '00:00' and the driver 'system'
> PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver
> isapnp: Scanning for PnP cards...
> isapnp: Card 'CS4236B'
> isapnp: Card 'U.S.Robotics Inc. Sportster 33.6 FAX Internal'
> isapnp: 2 Plug & Play cards detected total

The pnp layer was somewhat changed. I assume the person who did that
will fix up a few drivers as examples 

