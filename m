Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318900AbSHEW6D>; Mon, 5 Aug 2002 18:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318901AbSHEW6C>; Mon, 5 Aug 2002 18:58:02 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:56053 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318900AbSHEW6C>; Mon, 5 Aug 2002 18:58:02 -0400
Subject: Re: 2.4.19 MAESTRO sound /dev/dsp3 broken (luxury problem)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Voluspa <voluspa@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020806004059.43db99fb.voluspa@bigfoot.com>
References: <20020806004059.43db99fb.voluspa@bigfoot.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Aug 2002 01:20:23 +0100
Message-Id: <1028593223.18478.129.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 23:40, Voluspa wrote:
> 
> The fourth channel, aka /dev/dsp3, of the MAESTRO sound driver is broken (yeah, sob, sob) in 2.4.19 and -ac1. Last working that I've used, compiled as a module, was 2.4.19-pre10-ac1. The "sound" now coming out of that channel is a cry from the wilderness (confirmed with RealOne Player and gqmpeg and xine and...)

Can you try and find out exactly which kernel it broke at. The only
maestro change Im aware of was in rc1-ac7 and wouldn't have that affect
in any way I can imagine..

