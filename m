Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSG1UtT>; Sun, 28 Jul 2002 16:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSG1UtT>; Sun, 28 Jul 2002 16:49:19 -0400
Received: from mx2.elte.hu ([157.181.151.9]:56458 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317329AbSG1UtS>;
	Sun, 28 Jul 2002 16:49:18 -0400
Date: Sun, 28 Jul 2002 22:51:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce, patch] Thread-Local Storage (TLS) support for 
 Linux,2.5.28
In-Reply-To: <3D4459FF.1A98606C@tv-sign.ru>
Message-ID: <Pine.LNX.4.44.0207282250520.1365-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Jul 2002, Oleg Nesterov wrote:

> Well, load_TLS() and saving current %fs,%gs are just mem stores, no? I
> can't see any difference in terms of correctness.

yes, your patch is fine.

	Ingo

