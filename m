Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267213AbSLKUIA>; Wed, 11 Dec 2002 15:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267279AbSLKUIA>; Wed, 11 Dec 2002 15:08:00 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:45507
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267213AbSLKUH7>; Wed, 11 Dec 2002 15:07:59 -0500
Subject: Re: Bug Report 2.4.20: Interrupt sharing bogus
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20021211203403.130fc724.skraw@ithnet.com>
References: <20021211195501.7f6dff35.skraw@ithnet.com>
	<1039635955.18587.12.camel@irongate.swansea.linux.org.uk> 
	<20021211203403.130fc724.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 20:53:13 +0000
Message-Id: <1039639993.18587.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 19:34, Stephan von Krawczynski wrote:

> Is this sufficient? This is from my tried (bogus) setup:
> 
> CONFIG_X86_GOOD_APIC=y
> # CONFIG_X86_UP_APIC is not set
> # CONFIG_X86_UP_IOAPIC is not set

It is

