Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318885AbSHSNiT>; Mon, 19 Aug 2002 09:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318886AbSHSNiT>; Mon, 19 Aug 2002 09:38:19 -0400
Received: from [209.167.240.9] ([209.167.240.9]:61181 "EHLO
	ottonexc1.peregrine.com") by vger.kernel.org with ESMTP
	id <S318885AbSHSNiT>; Mon, 19 Aug 2002 09:38:19 -0400
Subject: Re: Does Solaris really scale this well? [OT]
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208181228330.13351-100000@sharra.ivimey.org>
References: <Pine.LNX.4.44.0208181228330.13351-100000@sharra.ivimey.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Aug 2002 09:42:21 -0400
Message-Id: <1029764541.32209.72.camel@dlacoste.ottawa.loran.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 08:33, Ruth Ivimey-Cook wrote:
> It is also instructive to note that in many cases, the peak processor power is 
> obtained by multiplying individual peak power by the number of processors, 
> with no notice taken of the costs of synchronisation, memory access or 
> communication. Consequently, many new owners of supercomputers are very 
> disappointed with their new 'baby' when they find it's not nearly as powerful 
> as they had been told.

It is also important to note that most benchmarks go out of their
way to analyze this situation properly in the massively parallel
supercomputer world, and that for the most part supercomputers excel
in I/O bandwidth more than CPU power, so if you bought your SV2 to
run quake you _deserve_ to only get 100fps :)

To try to bring this a little more back on topic, is there any
particular group in the Linux community who's dissatisfied with
our scalability (except for IBM, who seem to be working on this
issue already.  I mean anyone who's _not_ seeing things done to
rectify the situation :)

Dana Lacoste
Ottawa

