Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131561AbRCSTvX>; Mon, 19 Mar 2001 14:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131563AbRCSTvO>; Mon, 19 Mar 2001 14:51:14 -0500
Received: from [64.41.138.173] ([64.41.138.173]:5590 "EHLO
	simon.digitalimpact.com") by vger.kernel.org with ESMTP
	id <S131561AbRCSTvH>; Mon, 19 Mar 2001 14:51:07 -0500
Message-ID: <3AB638B3.545D7B26@digitalimpact.com>
Date: Mon, 19 Mar 2001 11:49:56 -0500
From: "Shane Y. Gibson" <sgibson@digitalimpact.com>
Organization: Digital Impact
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Oops 0000 and 0002 on dual PIII 750 2.4.2 SMP platform
In-Reply-To: <Pine.LNX.4.21.0103151954260.4383-100000@freak.distro.conectiva> <3AB13E47.7C777DF3@digitalimpact.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Shane Y. Gibson" wrote:
> 
> Marcelo Tosatti wrote:
> >
> > Did'nt you get a message similar to
> >
> > "kernel BUG at page_alloc.c line xxx!"

Okay, I set the nmi_watchdog=0 options for LILO.  Now on crashes,
I get ZERO panic output in the log files.  I found some old
PII 450s, and don't seem to get any panics when I run the PII450s.

I'll remove the nmi_watchdog option, and put the 750s back in,
and see if I can get anymore panic output.

v/r
Shane

--
Shane Y. Gibson                     sgibson@digitalimpact.com
Network Architect                        (408) 447-8253  work
IT Data Center Operations                (650) 302-0193  cell
Digital Impact, Inc.                     (408) 447-8298   fax

     "The whole problem with the world is that fools and
      fanatics are always so certain of themselves,  and
      wiser people so full of doubts."  Bertrand Russell
