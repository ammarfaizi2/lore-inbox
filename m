Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318033AbSHZVGd>; Mon, 26 Aug 2002 17:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318148AbSHZVGc>; Mon, 26 Aug 2002 17:06:32 -0400
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:25615 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S318033AbSHZVGb>; Mon, 26 Aug 2002 17:06:31 -0400
Date: Mon, 26 Aug 2002 23:10:44 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Suggestion for *config (was: 2.4.20-pre4-ac2 - where are the drivers 3COM ?)
Message-ID: <20020826211044.GA11150@merlin.emma.line.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020826122920.GA14018@debian> <1030367592.28478.10.camel@walker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030367592.28478.10.camel@walker>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2002, Lucio Maciel wrote:

> Try to enable ISA support...
> 
> 
> On Mon, 2002-08-26 at 09:29, Stephane Wirtel wrote:
> > in the menu "Ethernet (10 or 100Mbit)", i founded only one driver for 3COM
> > cards, where are the others ? deleted ?

Hum, it might be really useful if the *config tools had two options:

1. "show me all the drivers" (and what they depend on) -- xconfig is
   halfway there

2. "search driver"

Is anyone keeping a *config TO-DO list?
