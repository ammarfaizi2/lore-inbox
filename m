Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313690AbSD0M4C>; Sat, 27 Apr 2002 08:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSD0M4B>; Sat, 27 Apr 2002 08:56:01 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:59646 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S313690AbSD0M4A>; Sat, 27 Apr 2002 08:56:00 -0400
Date: Sat, 27 Apr 2002 15:55:51 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Martin Bene <martin.bene@icomedias.com>, linux-kernel@vger.kernel.org
Subject: 48-bit IDE [Re: 160gb disk showing up as 137gb]
Message-ID: <20020427125551.GG10849@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Martin Bene <martin.bene@icomedias.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <D143FBF049570C4BB99D962DC25FC2D2159B3A@freedom.icomedias.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 12:16:06PM +0200, you [Martin Bene] wrote:
> 
> IDE: The kernel IDE driver needs to support 48-bit addresseing to support
> 160GB.
> 
> (...) however, you can do something about the linux ATA driver: code
> is in the 2.4.19-pre tree, it went in with 2.4.19-pre3.

But which IDE controllers support 48-bit addressing? Not all of them? Does
linux IDE driver support 48-bit for all of them? Do they require BIOS
upgrade in order to operate 48-bit?

Or can I just grab a 160GB Maxtor and 2.4.19-preX, stick them into whatever
box I have and be done with it?


-- v --

v@iki.fi
