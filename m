Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267584AbSLNKFw>; Sat, 14 Dec 2002 05:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267587AbSLNKFw>; Sat, 14 Dec 2002 05:05:52 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:27275 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267584AbSLNKFv>;
	Sat, 14 Dec 2002 05:05:51 -0500
Date: Sat, 14 Dec 2002 10:13:27 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Courtney Grimland <cgrimland@yahoo.com>
Cc: BoehmeSilvio <Boehme.Silvio@afb.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-ac1 KT400 AGP support
Message-ID: <20021214101327.GB30545@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Courtney Grimland <cgrimland@yahoo.com>,
	BoehmeSilvio <Boehme.Silvio@afb.de>, linux-kernel@vger.kernel.org
References: <2F4E8F809920D611B0B300508BDE95FE294452@AFB91> <20021213195759.3233dc42.cgrimland@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021213195759.3233dc42.cgrimland@yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 07:57:59PM -0600, Courtney Grimland wrote:
 > You should be able to set AGP to 4x or 2x in the BIOS.

Aparently some KT400 BIOS's got clever, and took away the option.
They switch to AGP 3.0 if an AGP 3.0 card is present, and drop
back to 2.0 if a 2.0 card is present.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
