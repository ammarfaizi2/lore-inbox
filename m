Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTFJV0y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTFJVZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:25:10 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47527
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262269AbTFJVYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 17:24:48 -0400
Subject: Re: Wrong number of cpus detected/reported
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steven Cole <elenstev@mesatop.com>
Cc: Samuel Flory <sflory@rackable.com>, John Appleby <john@dnsworld.co.uk>,
       xyko_ig@ig.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1055279041.2270.42.camel@spc9.esa.lanl.gov>
References: <434747C01D5AC443809D5FC540501131569E@bobcat.unickz.com>
	 <3EE64161.5010102@rackable.com>
	 <1055279041.2270.42.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055280955.32661.35.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jun 2003 22:35:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips	: 2798.38
> 
> See that ht flag near the end?

The ht flag means the ht facilities (mtrr etc) are present, doesnt mean
HT necessarily is

