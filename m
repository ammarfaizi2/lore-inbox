Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261916AbRESRp4>; Sat, 19 May 2001 13:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbRESRps>; Sat, 19 May 2001 13:45:48 -0400
Received: from geos.coastside.net ([207.213.212.4]:46765 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261910AbRESRpj>; Sat, 19 May 2001 13:45:39 -0400
Mime-Version: 1.0
Message-Id: <p0510031eb72c5f11b8c7@[207.213.214.37]>
In-Reply-To: <81BywVLHw-B@khms.westfalen.de>
In-Reply-To: <811opRpHw-B@khms.westfalen.de>
 <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com>
 <p05100316b7272cdfd50c@[207.213.214.37]> <811opRpHw-B@khms.westfalen.de>
 <p05100301b72a335d4b61@[10.128.7.49]> <81BywVLHw-B@khms.westfalen.de>
Date: Sat, 19 May 2001 10:36:14 -0700
To: kaih@khms.westfalen.de (Kai Henningsen), linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: LANANA: To Pending Device Number Registrants
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:42 AM +0200 2001-05-19, Kai Henningsen wrote:
>  > Jeff Garzik's ethtool
>  > extension at least tells me the PCI bus/dev/fcn, though, and from
>>  that I can write a userland mapping function to the physical
>>  location.
>
>I don't see how PCI bus/dev/fcn lets you do that.

I know from system documentation, or can figure out once and for all 
by experimentation, the correspondence between PCI bus/dev/fcn and 
physical locations. Jeff's extension gives me the mapping between 
eth# and PCI bus/dev/fcn, which is not otherwise available (outside 
the kernel).
-- 
/Jonathan Lundell.
