Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267111AbSLKKvC>; Wed, 11 Dec 2002 05:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbSLKKvC>; Wed, 11 Dec 2002 05:51:02 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:35476 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S267111AbSLKKvC>; Wed, 11 Dec 2002 05:51:02 -0500
Date: Wed, 11 Dec 2002 10:58:08 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Daniel Egger <degger@fhm.edu>, Joseph <jospehchan@yahoo.com.tw>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
Message-ID: <20021211105808.GA17354@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Daniel Egger <degger@fhm.edu>, Joseph <jospehchan@yahoo.com.tw>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw> <20021210055215.GA9124@suse.de> <1039504941.30881.10.camel@sonja> <200212110829.gBB8Tja05013@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212110829.gBB8Tja05013@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 11:19:23AM -0200, Denis Vlasenko wrote:
 > > Prolly I would have to do more benchmarking to find out about
 > > aligment advantages.
 > I heard cmovs are microcoded in Centaurs.
 > s...l...o...w...

Hardly surprising given that the chip isn't targetted at the performance
market.

        Dave
