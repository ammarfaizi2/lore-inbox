Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318913AbSHMCzy>; Mon, 12 Aug 2002 22:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318914AbSHMCzx>; Mon, 12 Aug 2002 22:55:53 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:19205 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318913AbSHMCzx>; Mon, 12 Aug 2002 22:55:53 -0400
Date: Mon, 12 Aug 2002 22:53:25 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Pete de Zwart <dezwart@froob.net>
cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: 2.4.19: drivers/usb/printer.c usblpX on fire
In-Reply-To: <20020809204421.GA27819@niflheim>
Message-ID: <Pine.LNX.3.96.1020812225211.7583A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Aug 2002, Pete de Zwart wrote:

> Around about 1010h 09/08/2002, Samuel Flory emitted the following wisdom:
> >   The printer on fire message is the traditional Un*x error message for
> > unknown error on a printer.
> 
> 	What I don't understand is why the misleading message is sent
> instead of the printer driver stating that it has received an unknown printer
> error code and printing the code number.

See the paragraph you quoted.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

