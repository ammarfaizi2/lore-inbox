Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbSL3OUs>; Mon, 30 Dec 2002 09:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266978AbSL3OUr>; Mon, 30 Dec 2002 09:20:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4481
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266977AbSL3OUq>; Mon, 30 Dec 2002 09:20:46 -0500
Subject: Re: How much we can trust packet timestamping
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: uaca@alumni.uv.es
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021230130148.GB1591@pusa.informat.uv.es>
References: <20021230112838.GA928@pusa.informat.uv.es>
	<1041253743.13097.3.camel@irongate.swansea.linux.org.uk> 
	<20021230130148.GB1591@pusa.informat.uv.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 15:10:45 +0000
Message-Id: <1041261045.13684.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 13:01, uaca@alumni.uv.es wrote:
> Anybody know about a Linux driver that supports doing IRQ raise time
> sampling? any doc/pointer/suggestion would be greatly appreciated

Caederus has engineers who did the ISA bus hardware that led to the
SIOCGSTAMP facility in the first place (then the tcpdump type folks
decided it was really rather cool so it went generic anyway)

www.caederus.co.uk

I don't know if anyone is doing this in the PCI bus world

