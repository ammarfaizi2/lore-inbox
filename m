Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbUAGXAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUAGXAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:00:06 -0500
Received: from intra.cyclades.com ([64.186.161.6]:6021 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262033AbUAGXAB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:00:01 -0500
Date: Wed, 7 Jan 2004 20:58:49 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: "Yu, Luming" <luming.yu@intel.com>, andreas@xss.co.at, andrew@walrond.org,
       linux-kernel@vger.kernel.org
Subject: Re: ACPI: problem on ASUS PR-DLS533
In-Reply-To: <20040107133508.6798d1b9.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.58L.0401072057180.29393@logos.cnet>
References: <3ACA40606221794F80A5670F0AF15F8401720C88@PDSMSX403.ccr.corp.intel.com>
 <20040107133508.6798d1b9.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Jan 2004, Stephan von Krawczynski wrote:

> On Wed, 7 Jan 2004 18:50:03 +0800
> "Yu, Luming" <luming.yu@intel.com> wrote:
>
> > >I have some TRL-DLS here (P-III). They have dual AIC onboard which are
> > not
> > >recognised under 2.4.24 but work flawlessly with ACPI in 2.4.23.
> >
> > Are you sure?  You seems to want to say this is a regression.
>
> Yes. That is exactly what happened.
>
> 2.4.23 works flawlessly
> 2.4.24 does not recognise both onboard aic

Stephan,

Weird -- nothing changed in 2.4.24 which could cause such regression.

Can you please confirm this?
