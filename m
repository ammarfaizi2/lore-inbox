Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbSJJGwk>; Thu, 10 Oct 2002 02:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263277AbSJJGwk>; Thu, 10 Oct 2002 02:52:40 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:60423 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263276AbSJJGwj>; Thu, 10 Oct 2002 02:52:39 -0400
Message-Id: <200210100648.g9A6mlp01447@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Martin Josefsson <gandalf@wlug.westbo.se>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Looking for testers with these NICs
Date: Thu, 10 Oct 2002 09:42:13 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Adam Kropelin <akropel1@rochester.rr.com>, linux-kernel@vger.kernel.org
References: <200210091637.g99Gbmp30784@Port.imtp.ilyichevsk.odessa.ua> <200210091744.g99HiKp31184@Port.imtp.ilyichevsk.odessa.ua> <1034186251.615.44.camel@tux>
In-Reply-To: <1034186251.615.44.camel@tux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 October 2002 15:57, Martin Josefsson wrote:
> On Thu, 2002-10-10 at 00:37, Denis Vlasenko wrote:
> > I'd suggest SMP/preempt heavy IO. Is there stress test software for
> > NICs? What is pktgen?
>
> A kernelmodule that's capable of generating over a million packets
> per second on a fast enough machine. It stresstests NIC's and
> NIC-drivers a lot.

Indeed, I see it in 2.4, but where it has gone from 2.5?!
--
vda
