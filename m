Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbTICLmS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 07:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTICLmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 07:42:18 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:29899 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261917AbTICLmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 07:42:17 -0400
Subject: Re: [ACPI] Where do I send APIC victims?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: Roger Luethi <rl@hellgate.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
In-Reply-To: <200309031148.03941.adq_dvb@lidskialf.net>
References: <20030903080852.GA27649@k3.hellgate.ch>
	 <200309031123.58713.adq_dvb@lidskialf.net>
	 <20030903093808.GA28594@k3.hellgate.ch>
	 <200309031148.03941.adq_dvb@lidskialf.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062589205.19059.6.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 12:40:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-03 at 11:48, Andrew de Quincey wrote:
> 2.4.22 has the ACPI from 2.6 backported into it, (which includes my patch for 
> nforce2 boards) so it will start having the same issue with the BIOS bug in 
> KT333/KT400  boards.

It does - 2.4.22pre7 is great on my boxes, 2.4.22 final ACPI is
basically unusable on anything I own thats not intel. 

