Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030521AbWHIIkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030521AbWHIIkB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWHIIkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:40:00 -0400
Received: from loewe.unit-netz.de ([212.202.148.42]:39839 "EHLO
	loewe.unit-netz.de") by vger.kernel.org with ESMTP id S1030580AbWHIIj7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:39:59 -0400
Content-class: urn:content-classes:message
Subject: Re: fctnl(F_SETSIG) no longer works in 2.6.17, does in 2.6.16.
Date: Wed, 9 Aug 2006 10:39:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <664E3671B2B6DC439E0C9FFCF8E40CA205F4D1@exchange.I-BNEX>
In-Reply-To: <1155043590.5673.13.camel@localhost>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: Re: fctnl(F_SETSIG) no longer works in 2.6.17, does in 2.6.16.
Thread-Index: Aca67lSTYZuFqDT6SAyLJkXdolZPugAoJVHw
From: "Beschorner Daniel" <Daniel.Beschorner@facton.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: <linux-kernel@vger.kernel.org>, <orion@cora.nwra.com>,
       <76306.1226@compuserve.com>, <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe this ought to fix it.
>
> Cheers,
>  Trond

Thanks, the Samba problems are gone with this patch.
Maybe a 2.6.17.x candidate?

Daniel
