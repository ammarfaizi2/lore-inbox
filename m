Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318293AbSGRS06>; Thu, 18 Jul 2002 14:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318295AbSGRS06>; Thu, 18 Jul 2002 14:26:58 -0400
Received: from divine.city.tvnet.hu ([195.38.100.154]:32520 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S318293AbSGRS0z>; Thu, 18 Jul 2002 14:26:55 -0400
Date: Thu, 18 Jul 2002 19:31:53 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Robert Love <rml@tech9.net>
cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
In-Reply-To: <Pine.LNX.4.30.0207181900390.30902-100000@divine.city.tvnet.hu>
Message-ID: <Pine.LNX.4.30.0207181930170.30902-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Jul 2002, Szakacsits Szabolcs wrote:
> And my point (you asked for comments) was that, this is only (the
> harder) part of the solution making Linux a more reliable (no OOM
> killing *and* root always has the control) and cost effective platform
> (no need for occasionally very complex and continuous resource limit
> setup/adjusting, especially for inexpert home/etc users).

Ahh, I figured out your target, embedded devices. Yes it's good for
that but not enough for general purpose.

	Szaka

