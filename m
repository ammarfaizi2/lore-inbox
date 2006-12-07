Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032050AbWLGLZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032050AbWLGLZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 06:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032052AbWLGLZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 06:25:56 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53151 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032050AbWLGLZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 06:25:55 -0500
Date: Thu, 7 Dec 2006 12:24:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: sergio@sergiomb.no-ip.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] ACPI, i686, x86_64: fix laptop bootup hang in init_acpi()
Message-ID: <20061207112424.GA29660@elte.hu>
References: <20061206223025.GA17227@elte.hu> <1165458527.16955.58.camel@monteirov> <200612070547.56436.fzu@wemgehoertderstaat.de> <20061207110944.GD11207@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207110944.GD11207@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:
> 
> > Am Donnerstag, 7. Dezember 2006 03:28 schrieb Sergio Monteiro Basto:
> > > On Wed, 2006-12-06 at 23:30 +0100, Ingo Molnar wrote:
> > > > Subject: [patch] ACPI, i686, x86_64: fix laptop bootup hang in init_acpi()
> > > > From: Ingo Molnar <mingo@elte.hu>
> > > Hi Ingo,
> > > Just curiosity ,have we this patch on 2.6.19-1.rt6 ?
> > 
> > No, its in rt7.
> 
> yeah, it's in -rt7. [ -rt6 is more than 1 day old now, so it's truly 
> ancient stuff ;-) ]

did i really say -rt7? The ancient -rt7 stuff is 12+ hours old already, 
and there's the 1 minute old -rt8 available (patch and yum rpms too). 
Sheesh ... ;-)

	Ingo
