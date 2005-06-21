Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVFUBdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVFUBdf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 21:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVFUBbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 21:31:35 -0400
Received: from unused.mind.net ([69.9.134.98]:28072 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S261772AbVFUBU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 21:20:58 -0400
Date: Mon, 20 Jun 2005 18:18:37 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-Reply-To: <20050618122805.GA32041@elte.hu>
Message-ID: <Pine.LNX.4.58.0506201815430.10011@echo.lysdexia.org>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com>
 <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com>
 <20050616173247.GA32552@elte.hu> <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org>
 <Pine.LNX.4.58.0506171419050.786@echo.lysdexia.org> <20050618122805.GA32041@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jun 2005, Ingo Molnar wrote:

> * William Weston <weston@lysdexia.org> wrote:
> 
> > Running -48-36 on the Xeon/HT box, I lost keyboard and network after a 
> > couple hours.  Same .config as was used for -48-33 (attached... forgot 
> > to send in previous email).  Xscreensaver was still running with no 
> > way to unlock the console.  Back to -48-33 for the time being.
> 
> does -48-37 work any better?

Up almost three hours with -48-37, and no issues so far.  Thanks, Ingo. 
I'll let this run for a couple of days and then try out the -50-xx series.


--ww <weston@sysex.net>
