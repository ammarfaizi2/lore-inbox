Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267616AbSLSKf7>; Thu, 19 Dec 2002 05:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267615AbSLSKf6>; Thu, 19 Dec 2002 05:35:58 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:27550 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267616AbSLSKf4>;
	Thu, 19 Dec 2002 05:35:56 -0500
Date: Thu, 19 Dec 2002 10:43:21 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Courtney Grimland <cgrimland@yahoo.com>
Cc: Tupshin Harper <tupshin@tupshin.com>, linux-kernel@vger.kernel.org
Subject: Re: Via KT400
Message-ID: <20021219104321.GC29122@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Courtney Grimland <cgrimland@yahoo.com>,
	Tupshin Harper <tupshin@tupshin.com>, linux-kernel@vger.kernel.org
References: <001301c2a6ed$d9e7c3e0$0100a8c0@pcs686> <3E010F07.3000708@tupshin.com> <20021218232653.45c6eac7.cgrimland@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021218232653.45c6eac7.cgrimland@yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 11:26:53PM -0600, Courtney Grimland wrote:
 > I have the 7VAXP.  I only had problems with AGP and sound, and using
 > 2.4.20-ac2 absolutely everything on this board works (finally -
 > sound!).  AGP worked in 2.4.20-ac1 as well as 2.4.21-pre1.  I think
 > the the IDE issue was resolved in 2.4.20.

The AGP only works if the chipset is in 2.0 compatability mode.
Luckily some BIOSen out there seem to do that if a 2.0 card is present.
If you have an AGP 3.0 card in there you're shit out of luck right now.
I'm working on it..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
