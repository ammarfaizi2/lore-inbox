Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTFJVp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTFJVoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:44:38 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:11416 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S264030AbTFJVnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 17:43:35 -0400
Subject: Re: Wrong number of cpus detected/reported
From: Steven Cole <elenstev@mesatop.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Samuel Flory <sflory@rackable.com>, John Appleby <john@dnsworld.co.uk>,
       xyko_ig@ig.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1055280955.32661.35.camel@dhcp22.swansea.linux.org.uk>
References: <434747C01D5AC443809D5FC540501131569E@bobcat.unickz.com>
	 <3EE64161.5010102@rackable.com>
	 <1055279041.2270.42.camel@spc9.esa.lanl.gov>
	 <1055280955.32661.35.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1055281927.2269.47.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 10 Jun 2003 15:52:07 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 15:35, Alan Cox wrote:
> > wp		: yes
> > flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> > bogomips	: 2798.38
> > 
> > See that ht flag near the end?
> 
> The ht flag means the ht facilities (mtrr etc) are present, doesnt mean
> HT necessarily is

Is there a reliable method, apart from knowing 'a priori' the mapping
from CPU models and stepping to hyperthreading capability?

Steven

