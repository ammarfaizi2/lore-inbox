Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264842AbTANRcF>; Tue, 14 Jan 2003 12:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264844AbTANRcF>; Tue, 14 Jan 2003 12:32:05 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:53468 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S264842AbTANRcE>;
	Tue, 14 Jan 2003 12:32:04 -0500
Date: Tue, 14 Jan 2003 09:40:52 -0800
To: Neale Banks <neale@lowendale.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Jean Tourrilhes <jt@hpl.hp.com>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: [TRIVIAL 2.2] CONFIG_NET_RADIO and Wireless Extensions
Message-ID: <20030114174052.GB27898@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <Pine.LNX.4.05.10301141720390.27512-100000@marina.lowendale.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.05.10301141720390.27512-100000@marina.lowendale.com.au>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 05:34:49PM +1100, Neale Banks wrote:
> Hi Alan,
> 
> Configure.help in 2.2 appearss, er, "misleading" re the implications of
> CONFIG_NET_RADIO as selecting CONFIG_NET_RADIO (at least) includes the
> /proc/net/wireless stuff in net/core/dev.c. Appended patch lifts
> apparently more correct text from 2.4.

	No problem.

	Jean
