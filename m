Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbTCIMmj>; Sun, 9 Mar 2003 07:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262507AbTCIMmj>; Sun, 9 Mar 2003 07:42:39 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:33797 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S262506AbTCIMmi>; Sun, 9 Mar 2003 07:42:38 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303091255.h29Ct2aF001120@81-2-122-30.bradfords.org.uk>
Subject: Re: PROBLEM
To: fkosa@eposta.hu (=?ISO-8859-1?Q?K=F3sa?= Ferenc)
Date: Sun, 9 Mar 2003 12:55:02 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1047210594.13821.37.camel@daisy> from "=?ISO-8859-1?Q?K=F3sa?= Ferenc" at Mar 09, 2003 12:49:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. Newer kernels do not boot on 386
> 
> 2. I use linux successfully since 1997. A year ago I've tried to use
> linux on an AMD 5x86, and I realized that newer kernels (>2.4.13) do no=
> t
> boot. It starts: "loading linux........" and then after a while it
> reboots the computer, before "Ok, booting the kernel". I found the same
> problem on a Cyrix 486SLC2 too. I tried compile kernels by myself, but
> they did the same too, except for 2.4.13. The official Debian
> kernel-images failed too. I use lilo-2.2, with debian 3.0 stable
> (woody).

I've used 2.4.18 extensively on an Intel 486 SX-25, without problems.
I did notice the immediate rebooting problem using a few old 2.5.x
trees, but that was months ago, around the 2.5.40 timeframe, more
recent 2.5.x trees worked fine.

Incidently, I haven't had time to do my usual testing on low spec
machines recently, but intend restart that at the earliest
opportunity.

John.
