Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267021AbSL3Q20>; Mon, 30 Dec 2002 11:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267022AbSL3Q20>; Mon, 30 Dec 2002 11:28:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42113
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267021AbSL3Q2Z>; Mon, 30 Dec 2002 11:28:25 -0500
Subject: Re: APIC with SIS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021230173333.5f28edb9.skraw@ithnet.com>
References: <20021230170822.1b79ebb3.skraw@ithnet.com>
	<1041267723.13956.24.camel@irongate.swansea.linux.org.uk> 
	<20021230173333.5f28edb9.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 17:18:29 +0000
Message-Id: <1041268709.13684.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 16:33, Stephan von Krawczynski wrote:
> > You need some kernel patches, updated ACPI and ACPI enabled to use the
> > SIS APIC in this setup
> 
> Where to find?

Current ACPI is on sourceforge. The SIS APIC workaround bits haven't yet
been backported to 2.4, so you either do the backport or wait 8)

