Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318338AbSGRWAt>; Thu, 18 Jul 2002 18:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318346AbSGRWAt>; Thu, 18 Jul 2002 18:00:49 -0400
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:16513 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S318338AbSGRWAs>; Thu, 18 Jul 2002 18:00:48 -0400
Date: Fri, 19 Jul 2002 00:03:44 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: William Lee Irwin III <wli@holomorphy.com>
cc: Wolfgang <w.morandell@netway.at>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel panic with linux-2.4.19-rc2-ac1
In-Reply-To: <20020718215902.GU1096@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0207190002540.7956-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, William Lee Irwin III wrote:

> On Thu, Jul 18, 2002 at 11:48:59PM +0200, Wolfgang wrote:
> > I have switched from linux-2.4.19-rc1-ac7 to linux-2.4.19-rc2-ac1 (both
> > with preemptive patch). I use the same config but now thw kernel won't
> > start and spits out the following. If someone could point out where the
> > error is, I would be most grateful.
> > Please Cc me.
> >     Wolfgang
> 
> Please run ksymoops on this and send its output.

Better try ac2 first, since ac1 has a know crash bug.

/Tobias

