Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267989AbTAMG66>; Mon, 13 Jan 2003 01:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268236AbTAMG66>; Mon, 13 Jan 2003 01:58:58 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:16402 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267991AbTAMG65>; Mon, 13 Jan 2003 01:58:57 -0500
Message-Id: <200301130658.h0D6w5s26382@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: andrea.glorioso@binary-only.com
Subject: Re: Are linux network drivers really affected by this?
Date: Mon, 13 Jan 2003 08:57:47 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1042116723.2556.3.camel@station3> <200301101211.h0ACBIs16337@Port.imtp.ilyichevsk.odessa.ua> <87y95t12ga.fsf@topo.binary-only.priv>
In-Reply-To: <87y95t12ga.fsf@topo.binary-only.priv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 January 2003 16:53, andrea.glorioso@binary-only.com wrote:
> >>>>> "dv" == Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
> >>>>> writes:
>
>     dv> Too much work for zero gain
>
> `Too much work' refers to coding time or to kernel work?

Coding.

IMHO:

Zero padding is secure enough.
There is no point spending time coding random
padding, config options, etc.
--
vda
