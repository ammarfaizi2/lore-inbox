Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVGCHhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVGCHhW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 03:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVGCHhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 03:37:22 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:1510 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261386AbVGCHhR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 03:37:17 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: ASUS K8N-DL Beta BIOS
From: Alexander Nyberg <alexn@telia.com>
To: Sean Bruno <sean.bruno@dsl-only.net>
Cc: Andi Kleen <ak@muc.de>, Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "Hodle, Brian" <BHodle@harcroschem.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'ipsoa@posiden.hopto.org'" <ipsoa@posiden.hopto.org>
In-Reply-To: <1120365125.4107.4.camel@home-lap>
References: <D9A1161581BD7541BC59D143B4A06294021FAAAF@KCDC1>
	 <1120246927.2764.26.camel@home-lap>
	 <200507021843.45450.s0348365@sms.ed.ac.uk>  <20050702194455.GA80118@muc.de>
	 <1120365125.4107.4.camel@home-lap>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 03 Jul 2005 09:37:16 +0200
Message-Id: <1120376236.1175.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lör 2005-07-02 klockan 21:32 -0700 skrev Sean Bruno:
> On Sat, 2005-07-02 at 21:44 +0200, Andi Kleen wrote:
> > > I can't really remember whether the detection problem was resolved; my 
> > > specific (APIC related) issue was.
> > > 
> > > Andi?
> > 
> > Does it work with acpi_skip_timer_override ? 
> > 
> > -Andi
> 
> Not to be a crank here, but I can't find reference to this
> function/variable/#DEFINE in any of the ACPI code nor can I find a
> decent reference to this in the lkml lists...So I must not understand
> your suggestion.
> 
> What are you asking me to check?

It's a boot command line parameter (Documentation/kernel-parameters.txt)

