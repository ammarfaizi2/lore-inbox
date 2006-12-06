Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936932AbWLFRUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936932AbWLFRUK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936934AbWLFRUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:20:10 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:39855 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936932AbWLFRUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:20:08 -0500
Message-ID: <4576FAF8.8020701@us.ibm.com>
Date: Wed, 06 Dec 2006 09:16:40 -0800
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] VIA and SiS AGP chipsets are x86-only
References: <20061204104314.GB3013@parisc-linux.org>	<4575F929.9020708@us.ibm.com>  <20061206034044.GS3013@parisc-linux.org> <1165382366.5469.78.camel@localhost.localdomain>
In-Reply-To: <1165382366.5469.78.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=AC84030F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Benjamin Herrenschmidt wrote:
> On Tue, 2006-12-05 at 20:40 -0700, Matthew Wilcox wrote:
>> On Tue, Dec 05, 2006 at 02:56:41PM -0800, Ian Romanick wrote:
>>> I don't know about SiS, but this is certainly *not* true for Via.  There
>>> are some PowerPC and, IIRC, Alpha motherboards that have Via chipsets.
>> Yes, but they don't have VIA *AGP*.  At least, that's what I've been
>> told by people who know those architectures.
> 
> Yeah, I don't know of any VIA AGP chipset used on ppc...
> 
> Pegasos has a VIA southbridge but no AGP.

I double checked, and you're right.  Please ignore my noise.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFdvr3X1gOwKyEAw8RAocaAJ4whaDqaAmCFzAgrnzyD+1bD/SRXACfb5eM
TcFVnRBmMQUyU8wyOxLISHE=
=ST0m
-----END PGP SIGNATURE-----
