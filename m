Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbSKKAqN>; Sun, 10 Nov 2002 19:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSKKAqM>; Sun, 10 Nov 2002 19:46:12 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:37507 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265270AbSKKAqM>;
	Sun, 10 Nov 2002 19:46:12 -0500
Date: Mon, 11 Nov 2002 00:51:43 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Martin Knoblauch <knobi@knobisoft.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory performance on Serverworks GC-LE based system poor?
Message-ID: <20021111005143.GA22055@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Martin Knoblauch <knobi@knobisoft.de>, linux-kernel@vger.kernel.org
References: <200211110130.13943.knobi@knobisoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211110130.13943.knobi@knobisoft.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 01:30:13AM +0100, Martin Knoblauch wrote:

 >  I have experienced extreme low STREAMS numbers (about 600 MB/sec for Triad) 
 > on two dual CPU systems based on the ServerWorks GC-LE chipset (SuperMicro 
 > P4DLR+ mainboard). Both systems had 2x2.4 GHz XEONs, 4GB of DDR memory and 
 > were running kernel 2.4.18. I would usually expect STREAMS numbers of about 
 > 2000 MB/sec for this kind of systems.
 > 
 > Does this ring any bells?

ISTR serverworks LE errata with MTRRs and write-combining.
Whether this is biting you or not I can't say.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
