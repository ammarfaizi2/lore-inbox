Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267172AbSLKOnA>; Wed, 11 Dec 2002 09:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267173AbSLKOnA>; Wed, 11 Dec 2002 09:43:00 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:38784 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267170AbSLKOm6>;
	Wed, 11 Dec 2002 09:42:58 -0500
Date: Wed, 11 Dec 2002 14:59:41 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Daniel Egger <degger@fhm.edu>, Joseph <jospehchan@yahoo.com.tw>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
Message-ID: <20021211145941.GA4726@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Daniel Egger <degger@fhm.edu>, Joseph <jospehchan@yahoo.com.tw>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw> <200212110829.gBB8Tja05013@Port.imtp.ilyichevsk.odessa.ua> <20021211105808.GA17354@codemonkey.org.uk> <200212111419.gBBEJua06684@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212111419.gBBEJua06684@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 05:09:34PM -0200, Denis Vlasenko wrote:
 > >  > I heard cmovs are microcoded in Centaurs.
 > >  > s...l...o...w...
 > > Hardly surprising given that the chip isn't targetted at the
 > > performance market.
 > *We Support 686 Instruction Set* plastered everywhere? ;)

It's an *optional* extension to the 686 as stated in
the Intel documentation.
 
		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
