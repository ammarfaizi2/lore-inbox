Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267899AbTBEK1C>; Wed, 5 Feb 2003 05:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267902AbTBEK1C>; Wed, 5 Feb 2003 05:27:02 -0500
Received: from ns.suse.de ([213.95.15.193]:61455 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267899AbTBEK1B>;
	Wed, 5 Feb 2003 05:27:01 -0500
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: gcc 2.95 vs 3.21 performance
X-Yow: I Know A Joke
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 05 Feb 2003 11:36:32 +0100
In-Reply-To: <200302050717.h157HTs16569@Port.imtp.ilyichevsk.odessa.ua> (Denis
 Vlasenko's message of "Wed, 5 Feb 2003 09:15:48 +0200")
Message-ID: <jevfzzj9ov.fsf@sykes.suse.de>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.3.50 (ia64-suse-linux)
References: <200302042011.h14KBuG6002791@darkstar.example.net>
	<3E40264C.5050302@WirelessNetworksInc.com>
	<200302050717.h157HTs16569@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:

|> I am damn sure that if you compile with less sadistic alignment
|> you will get smaller *and* faster kernel.

So why don't you try it out?  GCC offers everything you need for this
experiment.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
