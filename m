Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262053AbSI3NWH>; Mon, 30 Sep 2002 09:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262057AbSI3NWG>; Mon, 30 Sep 2002 09:22:06 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:65461 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262053AbSI3NWG>;
	Mon, 30 Sep 2002 09:22:06 -0400
Date: Mon, 30 Sep 2002 14:30:57 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Adam Voigt <adam@cryptocomm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.39 XConfig Processor Detection
Message-ID: <20020930133057.GA8868@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Adam Voigt <adam@cryptocomm.com>, linux-kernel@vger.kernel.org
References: <Pine.NEB.4.44.0209301257210.12605-100000@mimas.fachschaften.tu-muenchen.de> <1033389340.16337.14.camel@irongate.swansea.linux.org.uk> <20020930.052555.123500588.davem@redhat.com> <1033391751.16468.51.camel@irongate.swansea.linux.org.uk> <1033392021.1491.6.camel@beowulf.internetstore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033392021.1491.6.camel@beowulf.internetstore.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 09:20:21AM -0400, Adam Voigt wrote:
 > Apologies if this has already been noted or if I'm posting
 > this to the wrong place/annoying you very busy people needlessly,
 > but when I run XConfig, in the "Processor Type and Features" tab
 > it autodetects my processor as a Pentium-4 when in fact it is a
 > P3 700MHZ. The last time I installed a kernel (2.4.x) by hand, it did
 > autodetect the processor on that machine (Athlon), so I assume that
 > feature is still active. Anyways, here's the output from my cpuinfo:

 There's no 'autodetect' feature.
 Only defconfig, which sets the default option.
 These defaults match whatever Linus is currently using, so
 it seems he upgraded his Athlon box to a P4 8-)

 Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
