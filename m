Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319276AbSHNTyD>; Wed, 14 Aug 2002 15:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319277AbSHNTyD>; Wed, 14 Aug 2002 15:54:03 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:42714 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S319276AbSHNTyD>; Wed, 14 Aug 2002 15:54:03 -0400
Date: Wed, 14 Aug 2002 20:57:09 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
Message-ID: <20020814205709.E26404@kushida.apsleyroad.org>
References: <3D56B13A.D3F741D1@zip.com.au> <Pine.NEB.4.44.0208132322340.1351-100000@mimas.fachschaften.tu-muenchen.de> <ajc095$hk1$1@cesium.transmeta.com> <20020814194019.A31761@bitwizard.nl> <3D5AB250.3070104@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D5AB250.3070104@zytor.com>; from hpa@zytor.com on Wed, Aug 14, 2002 at 12:41:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Yes.  This is a gcc-specific wart, a bad idea from the start, and 
> apparently one which has caught up with them to the point that they've 
> had to abandon it.

It's still there in GCC 3.1.

-- Jamie
