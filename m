Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261304AbSI3Tmj>; Mon, 30 Sep 2002 15:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSI3Tmj>; Mon, 30 Sep 2002 15:42:39 -0400
Received: from dsl-213-023-038-108.arcor-ip.net ([213.23.38.108]:44948 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261304AbSI3Tmi>;
	Mon, 30 Sep 2002 15:42:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Peter Chubb <peter@chubb.wattle.id.au>,
       Thunder from the hill <thunder@lightweight.ods.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated v2
Date: Mon, 30 Sep 2002 21:48:10 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <15763.55020.35426.721691@wombat.chubb.wattle.id.au>
In-Reply-To: <15763.55020.35426.721691@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17w6WZ-0005pB-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is the problem these lists are intended to solve?

That's what I kept asking myself when I wrote the orginal push/pop
macros.  My conclusion was that there is no worthwhile expression of
these things in C.  Writing those macros was just something I had
to do so I could wallow in the ugliness and stop thinking "maybe
these things should be generic".

-- 
Daniel
