Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267440AbTBDTlW>; Tue, 4 Feb 2003 14:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267442AbTBDTlW>; Tue, 4 Feb 2003 14:41:22 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:51356 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267440AbTBDTkS>;
	Tue, 4 Feb 2003 14:40:18 -0500
Date: Tue, 4 Feb 2003 19:44:59 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: "Timothy D. Witham" <wookie@osdl.org>, vda@port.imtp.ilyichevsk.odessa.ua,
       root@chaos.analogic.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030204194459.GC6417@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	John Bradford <john@grabjohn.com>,
	"Timothy D. Witham" <wookie@osdl.org>,
	vda@port.imtp.ilyichevsk.odessa.ua, root@chaos.analogic.com,
	mbligh@aracnet.com, linux-kernel@vger.kernel.org,
	lse-tech@lists.sourceforge.net
References: <1044385759.1861.46.camel@localhost.localdomain> <200302041935.h14JZ69G002675@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302041935.h14JZ69G002675@darkstar.example.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 07:35:06PM +0000, John Bradford wrote:

 > Maybe we should create a KGCC fork, optimise it for kernel
 > complilations, then try to get our changes merged back in to GCC
 > mainline at a later date.

What exactly do you mean by "optimise for kernel compilations" ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
