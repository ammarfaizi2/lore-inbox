Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbTH2RkD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTH2RkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:40:03 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:46252 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261814AbTH2Rj7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:39:59 -0400
Date: Fri, 29 Aug 2003 19:39:57 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Voluspa <lista1@comhem.se>
Subject: Re: [PATCH]O19int
In-Reply-To: <200308291550.28159.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.51.0308291937540.31539@dns.toxicfilms.tv>
References: <200308291550.28159.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Small error in the just interactive logic has been corrected.
>
> Idle tasks get one higher priority than just interactive so they don't get
> swamped under heavy load.
>
> Cosmetic cleanup.
>
> Patch against 2.6.0-test4-mm2
Hey, now that's the best desktop kernel operation I have seen.

Everything is really smooth.

Thanks!

> Con
Maciej

