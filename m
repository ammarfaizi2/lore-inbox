Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318321AbSGRSpd>; Thu, 18 Jul 2002 14:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318322AbSGRSpd>; Thu, 18 Jul 2002 14:45:33 -0400
Received: from divine.city.tvnet.hu ([195.38.100.154]:25865 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S318321AbSGRSp3>; Thu, 18 Jul 2002 14:45:29 -0400
Date: Thu, 18 Jul 2002 19:50:28 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Robert Love <rml@tech9.net>
cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
In-Reply-To: <1027016939.1086.127.camel@sinai>
Message-ID: <Pine.LNX.4.30.0207181942240.30902-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Jul 2002, Robert Love wrote:
> An orthogonal issue is per-user resource limits and this may need to be
> coupled with that.  It is not a problem I am trying to solve, however.

About 99% of the people don't know about, don't understand or don't
care about resource limits. But they do care about cleaning up when
mess comes. Adding reserved root memory would be a couple of lines,
you can get ideas from the patch from here,
	http://mlf.linux.rulez.org/mlf/ezaz/reserved_root_memory.html

Surprisingly visited through google and people are asking for 2.4
patches, hint ;)

	Szaka

