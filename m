Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbTAJMJj>; Fri, 10 Jan 2003 07:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbTAJMJj>; Fri, 10 Jan 2003 07:09:39 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:38918 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262394AbTAJMJi>; Fri, 10 Jan 2003 07:09:38 -0500
Message-Id: <200301101211.h0ACBIs16337@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: andrea.glorioso@binary-only.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Are linux network drivers really affected by this?
Date: Fri, 10 Jan 2003 14:11:10 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1042116723.2556.3.camel@station3> <1042199207.28469.49.camel@irongate.swansea.linux.org.uk> <8765sx2r8u.fsf@topo.binary-only.priv>
In-Reply-To: <8765sx2r8u.fsf@topo.binary-only.priv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 January 2003 13:12, andrea.glorioso@binary-only.com wrote:
> >>>>> "ac" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>
>     ac> Most of  them will pad with zero.  We have a couple of
> drivers ac> that already pad with something along  the lines of
> "NetBSD is ac> a cool OS too.."
>
> Let's talk about subliminal messages, then. :)
>
> How sensible would it be to have a runtime or  compile time option
> for choosing between zero padding and  random values padding?  I
> think the variable length of the  padding could cause some
> performance problems, but I'm no kernel hacker nor cryptography
> expert.

Too much work for zero gain
--
vda
