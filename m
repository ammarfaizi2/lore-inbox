Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318782AbSHGRLV>; Wed, 7 Aug 2002 13:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318783AbSHGRLV>; Wed, 7 Aug 2002 13:11:21 -0400
Received: from p50887B26.dip.t-dialin.net ([80.136.123.38]:52958 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318782AbSHGRLU>; Wed, 7 Aug 2002 13:11:20 -0400
Date: Wed, 7 Aug 2002 11:13:47 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Andries Brouwer <aebr@win.tue.nl>
cc: davidsen@tmr.com, <linux-kernel@vger.kernel.org>
Subject: Re: Why 'mrproper'?
In-Reply-To: <20020807170041.GA259@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0208071111110.10270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 7 Aug 2002, Andries Brouwer wrote:
> Funny that you ask this question first now.
> mrproper came in 0.99p7
> distclean came in 0.99p14 as a synonym for mrproper.

"Mr. President, this is not exactly true."

The 'distclean' target also removes your editors backup files ("*~",
"#*#", "*.bak") and your patch leftovers ("*.orig", "*.rej"), notably your
".SUMS".

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-

