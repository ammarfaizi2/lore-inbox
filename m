Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUAVJjB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 04:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUAVJjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 04:39:00 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:64444 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S266216AbUAVJi5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 04:38:57 -0500
Date: Thu, 22 Jan 2004 11:35:42 +0200 (EET)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: GCS <gcs@lsc.hu>
cc: Valdis Kletnieks <valdis@turing-police.cc.vt.edu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 2.6.1-mm5 - oops during network initialization
In-Reply-To: <20040121154627.GB10508@lsc.hu>
Message-ID: <Pine.LNX.4.58.0401221134400.11009@hosting.rdsbv.ro>
References: <20040120000535.7fb8e683.akpm@osdl.org>
 <200401210638.i0L6cpeU003057@turing-police.cc.vt.edu>
 <Pine.LNX.4.58.0401211024520.28511@hosting.rdsbv.ro> <20040121154627.GB10508@lsc.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jan 2004, GCS wrote:

> On Wed, Jan 21, 2004 at 10:31:23AM +0200, Catalin BOIE <util@deuroconsult.ro> wrote:
> > On Wed, 21 Jan 2004, Valdis Kletnieks wrote:
> >
> > I can confirm I get this also.
> > > CONFIG_IPV6_PRIVACY=y
>  Can you both try it without the above? At least it's solved my problem, and
> I can have 'CONFIG_IPV6=y' and ipv6 netfilter options as modules.
>
> Hope this helps,
> GCS
>

2.6.2-rc1 works good.

---
Catalin(ux) BOIE
catab@deuroconsult.ro
