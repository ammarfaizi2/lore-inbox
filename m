Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318216AbSHGR2H>; Wed, 7 Aug 2002 13:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318623AbSHGR2H>; Wed, 7 Aug 2002 13:28:07 -0400
Received: from p50887B26.dip.t-dialin.net ([80.136.123.38]:61150 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318216AbSHGR2H>; Wed, 7 Aug 2002 13:28:07 -0400
Date: Wed, 7 Aug 2002 11:31:29 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Andi Kleen <ak@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
In-Reply-To: <20020807124153.A8592@wotan.suse.de>
Message-ID: <Pine.LNX.4.44.0208071127100.10270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 7 Aug 2002, Andi Kleen wrote:
> Alternatively CONFIG_NO_64BIT to work around this issue.

Please don't do this. This way leads to madness when 96/128 bit or
whatever !64 bit comes. (And I can confirm it's cool.) Don't you say
"well" here, I remember being f*cked up when we doubled the bit rate once
on another system. (It was from 4 to 8 bits, actually. Nice time.)

Hardly ANYTHING will be !CONFIG_NO_64BIT.

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-

