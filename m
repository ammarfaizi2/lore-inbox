Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264397AbUEMS4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbUEMS4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 14:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264404AbUEMS4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 14:56:17 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:17937 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S264397AbUEMS4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 14:56:12 -0400
Date: Thu, 13 May 2004 15:54:49 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-mm2 foibles
Message-ID: <20040513185449.GA731@lorien.prodam>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200405131442.27573.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405131442.27573.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Gene,

Em Thu, May 13, 2004 at 02:42:27PM -0400, Gene Heskett escreveu:

| I just booted to a 2.6.6-mm2 kernel, and discoverd I had no sound.  So 
| I logged back out of x, and found I had no keyboard!  ssh'd in from 
| the firewall and rebooted it.
| 
| Both sound, and the backswitch from x were working perfectly up to and 
| including 2.6.6.
| 
| 1400 mhz Athlon, half a gig of memory, FC1 all yum updates.
| 
| Ideas?

 I got something like that, but from the console: I was just using the
computer and my keyboard locks (at console). I tryed a ssh from
another machine and it worked (nothing special in log messages too),
so I rebooted.

 It happened two times in some minutes ago. I'm looking at suspects
patches, if it happens again I will try to reverse something.

-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>
