Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262074AbSIYTjY>; Wed, 25 Sep 2002 15:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbSIYTjY>; Wed, 25 Sep 2002 15:39:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:37787 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262074AbSIYTjX>;
	Wed, 25 Sep 2002 15:39:23 -0400
Date: Wed, 25 Sep 2002 21:53:17 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
In-Reply-To: <Pine.LNX.4.33.0209251245070.2836-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209252152590.18490-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Sep 2002, Linus Torvalds wrote:

> I want those [] gone too, I see no reason for them except to make the
> output ugly.

yep, i removed them already, patch in a minute, after i'm done with
testing.

	Ingo

