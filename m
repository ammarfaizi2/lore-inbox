Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318810AbSH1NEq>; Wed, 28 Aug 2002 09:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318813AbSH1NEq>; Wed, 28 Aug 2002 09:04:46 -0400
Received: from pD9E23990.dip.t-dialin.net ([217.226.57.144]:16577 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318810AbSH1NEp>; Wed, 28 Aug 2002 09:04:45 -0400
Date: Wed, 28 Aug 2002 07:08:50 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Pavel Machek <pavel@suse.cz>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [BUG] 2.5.30 swaps with no swap device mounted!!
In-Reply-To: <20020827135421.A39@toy.ucw.cz>
Message-ID: <Pine.LNX.4.44.0208280708020.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Aug 2002, Pavel Machek wrote:
> > It might be interesting to see what happens if you unplug the swap device 
> > after umounting.
> 
> In the same way it might be interesting to see what happens if you put
> cigarette into gasoline tank?

Well, you never know what unregistering does. It might happen to be 
ignored for swap, once unregistered.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

