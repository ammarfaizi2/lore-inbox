Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281558AbRLAKeN>; Sat, 1 Dec 2001 05:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284047AbRLAKeE>; Sat, 1 Dec 2001 05:34:04 -0500
Received: from news.heim1.tu-clausthal.de ([139.174.234.200]:4413 "EHLO
	neuemuenze.heim1.tu-clausthal.de") by vger.kernel.org with ESMTP
	id <S281558AbRLAKdx>; Sat, 1 Dec 2001 05:33:53 -0500
Date: Sat, 1 Dec 2001 11:34:00 +0100
From: Sven.Riedel@tu-clausthal.de
To: Ville Herva <vherva@viasys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HPT370 (KT7A-RAID) *corrupts* data - SAMSUNG SV8004H does it as well
Message-ID: <20011201113400.A629@moog.heim1.tu-clausthal.de>
In-Reply-To: <20011201115803.B10839@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011201115803.B10839@viasys.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 11:58:03AM +0200, Ville Herva wrote:
> - how come anyone else is not seeing this corruption (Abit KT7A, nevermind 
>   HPT370 is fairly popular)?

A friend of mine had an IBM DLTA drive attached to his HPT370
controller, and this combination proved to produce a whole lot of drive
errors (I can confirm this first hand), which went away after attaching
the drive to the main motherboard controller.
I can't say anything about data corruption though - I just asked him and
he said he didn't know of any, but that doesn't mean it didn't happen.

Regs,
Sven
-- 
Sven Riedel                      sr@gimp.org
Osteroeder Str. 6 / App. 13      sven.riedel@tu-clausthal.de
38678 Clausthal                  "Call me bored, but don't call me boring."
                                 - Larry Wall 
