Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268063AbTB1Skj>; Fri, 28 Feb 2003 13:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268061AbTB1Skj>; Fri, 28 Feb 2003 13:40:39 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60563
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268060AbTB1Ski>; Fri, 28 Feb 2003 13:40:38 -0500
Subject: Re: APIC problems .. AMD MPX chipset
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Patrick Finnegan <pat@purdueriots.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302281315560.23597-200000@ibm-ps850.purdueriots.com>
References: <Pine.LNX.4.44.0302281315560.23597-200000@ibm-ps850.purdueriots.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046462028.17697.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Feb 2003 19:53:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 18:31, Patrick Finnegan wrote:
> I've had this promblem since 2.4.x, and have just used the 'noapic' kernel
> argument as a work around.  I've decided that it might be nice to find out
> if a fix for this exists.
> 
> Hardware: ASUS K7M266-D Dual processor motherboard, amd 760mpx chipset,
>   pair of AMD Athlon MP 1700+ CPU's.

Upgrade your BIOS to at least 1007

