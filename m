Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261910AbSJITC1>; Wed, 9 Oct 2002 15:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262007AbSJITC1>; Wed, 9 Oct 2002 15:02:27 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:27382 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S261910AbSJITC0>;
	Wed, 9 Oct 2002 15:02:26 -0400
Date: Wed, 9 Oct 2002 15:08:04 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Looking for testers with these NICs
Message-ID: <20021009190804.GA18069@www.kroptech.com>
References: <200210091637.g99Gbmp30784@Port.imtp.ilyichevsk.odessa.ua> <20021009171452.GA9682@www.kroptech.com> <200210091744.g99HiKp31184@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210091744.g99HiKp31184@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 08:37:48PM -0200, Denis Vlasenko wrote:
> On 9 October 2002 15:14, Adam Kropelin wrote:
> > On Wed, Oct 09, 2002 at 07:31:17PM -0200, Denis Vlasenko wrote:
> > > ewrk3.c
> >
> > I've got a few of these laying around. Send whatever patches you want
> > tested and I'll give it a shot.
> 
> Please do your best in trying to break it, especially since you say you have
> more than one. Can you plug them all in one box?
> 
> I'd suggest SMP/preempt heavy IO. Is there stress test software for NICs?
> What is pktgen?

These are ISA nics and my SMP box has a lot of other hardware in it right now,
but I'll see what I can do. I haven't tried to do unreasonable things with old
hardware in a while so it should be good for a grin, anyway.

I'll report my findings.

--Adam

