Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281779AbRLSSSz>; Wed, 19 Dec 2001 13:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281691AbRLSSSo>; Wed, 19 Dec 2001 13:18:44 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:5616 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S281478AbRLSSSe>; Wed, 19 Dec 2001 13:18:34 -0500
Message-ID: <3C20D9DC.B14709FD@mvista.com>
Date: Wed, 19 Dec 2001 10:18:04 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin A. Brooks" <martin@jtrix.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: asynchronus multiprocessing
In-Reply-To: <1008776432.431.15.camel@unhygienix> <1008777560.431.19.camel@unhygienix>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin A. Brooks" wrote:
> 
> On Wed, 2001-12-19 at 15:40, Martin A. Brooks wrote:
> > Has there been any talk of (or work on) AMP support in the kernel?
> 
> I meant /asymmetric/ MP. Sorry.
> 
I have heard of some work.  As I understand it they are making an API
for cpu affinity.  It is real time, so they are also interested in the
schedule routines around cpu affinity as well.

What did you have in mind? 
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
