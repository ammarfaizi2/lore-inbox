Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318003AbSGWJQF>; Tue, 23 Jul 2002 05:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318006AbSGWJQF>; Tue, 23 Jul 2002 05:16:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38859 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318003AbSGWJQE>;
	Tue, 23 Jul 2002 05:16:04 -0400
Date: Tue, 23 Jul 2002 11:18:11 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, george anzinger <george@mvista.com>
Subject: Re: [patch] big IRQ lock removal, 2.5.27-D9
In-Reply-To: <3D3C76F0.307C6C3@tv-sign.ru>
Message-ID: <Pine.LNX.4.44.0207231117250.5058-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Jul 2002, Oleg Nesterov wrote:

> Not sure it is right time to such minor cleanups, but...

i've applied your patch to my tree - all of the irqlock patches are
cleanups to begin with.

	Ingo

