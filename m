Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVFRV6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVFRV6R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 17:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVFRV6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 17:58:17 -0400
Received: from 212-28-208-94.customer.telia.com ([212.28.208.94]:54027 "EHLO
	www.dewire.com") by vger.kernel.org with ESMTP id S261157AbVFRV6O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 17:58:14 -0400
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Sat, 18 Jun 2005 23:57:57 +0200
User-Agent: KMail/1.8.1
Cc: Kari Hurtta <hurtta+linux-kernel@leija.mh.fmi.fi>,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Patrick McFarland <pmcfarland@downeast.net>,
       "Richard B. Johnson" <linux-os@analogic.com>,
       Lukasz Stelmach <stlman@poczta.fm>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>
References: <200506181806.j5II6otS019215@leija.fmi.fi>
In-Reply-To: <200506181806.j5II6otS019215@leija.fmi.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506182357.58439.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lördagen den 18 juni 2005 20.06 skrev Kari Hurtta:
> > fredagen den 17 juni 2005 15.23 skrev M	åns Rullgård:
> > > Some characters can be encoded in several equally shortest ways.
> >
> > No they cannot. How to encode characters i explicitly and well defined.
> > If you don't follow the rules you are simply not producing UTF-8, but
> > something else.
> >
> > Every unicode character has exactly one  UTF-8 representation.
> >
> > -- robin
>
> You are confused between unicode characters and unicode codepoints.

Yes. i forgot about them. Thank you for reminding me. 

-- robin
