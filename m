Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263288AbVCKNVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbVCKNVA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 08:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbVCKNVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 08:21:00 -0500
Received: from atropo.wseurope.com ([195.110.122.67]:44246 "EHLO
	atropo.wseurope.com") by vger.kernel.org with ESMTP id S263288AbVCKNU4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 08:20:56 -0500
From: Fabio Coatti <fabio.coatti@wseurope.com>
Organization: Wireless Solutions S.p.A.
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: bonnie++ uninterruptible under heavy I/O load
Date: Fri, 11 Mar 2005 14:20:52 +0100
User-Agent: KMail/1.8
Cc: Simone Piunno <simone.piunno@wseurope.com>, linux-kernel@vger.kernel.org
References: <200503111208.20283.simone.piunno@wseurope.com> <200503111335.56782.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200503111335.56782.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503111420.52890.fabio.coatti@wseurope.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 12:35, venerdì 11 marzo 2005, Denis Vlasenko ha scritto:

> >
> > Unresponsiveness is not 2.6.11 specific (we've seen the same thing on
> > 2.6.10 and 2.6.8), not I/O scheduler specific ("as" and "deadline" behave
> > the same) and not CPU/SMP specific (reproduced on single P4 HT and single
> > P3), but only on these two DL585 servers we've seen bonnie++ resisting
> > kill -9 for tens of seconds.
> >
> > Of course on request I can provide any other useful info.
> > Any help is appreciated.
>
> I think Alt-SysRq-T will be interesting to see

Unfortunately this machine is on a remote location, so we don't have access to 
keyboard. In some days we will be able to have a report of Alt-SysRq-T, but 
until this  of course we can provide any information that can be gathered on 
a remote shell.

-- 
Fabio Coatti              Wireless Solutions SpA - DADA group   
Services Manager        Europe HQ, via Castiglione 25 Bologna 
http://www.wseurope.com     Tel: +390512966811 Fax: +390512966800
