Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318421AbSGRW1t>; Thu, 18 Jul 2002 18:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318422AbSGRW1t>; Thu, 18 Jul 2002 18:27:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23278 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318421AbSGRW1r>; Thu, 18 Jul 2002 18:27:47 -0400
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
From: Robert Love <rml@tech9.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L.0207181923180.12241-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0207181923180.12241-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Jul 2002 15:30:22 -0700
Message-Id: <1027031422.1555.161.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 15:24, Rik van Riel wrote:

> I see no reason to not merge this (useful) part. Not only
> is it useful on its own, it's also a necessary ingredient
> of whatever "complete solution" to control per-user resource
> limits.

I am glad we agree here - resource limits and strict overcommit are two
separate solutions to various problems.  Some they solve individually,
others they solve together.

I may use one, the other, both, or neither.  A clean abstract solution
allows this.

	Robert Love

