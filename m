Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264737AbUFGMjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264737AbUFGMjB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUFGMff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:35:35 -0400
Received: from gprs214-225.eurotel.cz ([160.218.214.225]:47232 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264728AbUFGMeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 08:34:06 -0400
Date: Mon, 7 Jun 2004 14:33:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: TazForEver@free.fr
Cc: linux-kernel@vger.kernel.org, cyplp@free.fr
Subject: Re: [2.6.6 panic] via-rhine and acpi sleep 3
Message-ID: <20040607123358.GB11860@elf.ucw.cz>
References: <40C314C4.4080006@dlfp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C314C4.4080006@dlfp.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> hello, i'm getting troubles with my epia boxes : epia via motherboard + 
> C3 processor.
> 
> the acpi STR sleep works fine (the CPU fan goes down) and wake up is ok. 
> But, i'm experiencing bugs with the builtin via-rhine network card. on 
> wake up, the network card seems to have been not correctly suspended : 
> it doesn't work anymore. i tried to find a way with acpi so that the 
> network interface is downed before sleep, the module unloaded and vice 
> versa on wake up. but that doesn't work.

Try suspend-to-disk working, first.

> on wake up, trying to re-activate my netcard, i often get some message 
> obout ill-formed ethernet frames. i also often get kernel panic but i've 
> not been able to save the kernel panic trace. i don't know how, so if 
> somebody could tell me how to save it ...

Pen and paper?
								Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc
