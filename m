Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261885AbSJIRwX>; Wed, 9 Oct 2002 13:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbSJIRwX>; Wed, 9 Oct 2002 13:52:23 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:29332 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S261885AbSJIRvv>;
	Wed, 9 Oct 2002 13:51:51 -0400
Subject: Re: Looking for testers with these NICs
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Adam Kropelin <akropel1@rochester.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200210091744.g99HiKp31184@Port.imtp.ilyichevsk.odessa.ua>
References: <200210091637.g99Gbmp30784@Port.imtp.ilyichevsk.odessa.ua>
	<20021009171452.GA9682@www.kroptech.com> 
	<200210091744.g99HiKp31184@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 09 Oct 2002 19:57:31 +0200
Message-Id: <1034186251.615.44.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-10 at 00:37, Denis Vlasenko wrote:

> I'd suggest SMP/preempt heavy IO. Is there stress test software for NICs?
> What is pktgen?

A kernelmodule that's capable of generating over a million packets per
second on a fast enough machine. It stresstests NIC's and NIC-drivers a
lot.

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat
you with experience.
