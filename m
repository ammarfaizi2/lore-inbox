Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262079AbSIYTVi>; Wed, 25 Sep 2002 15:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262080AbSIYTVi>; Wed, 25 Sep 2002 15:21:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:28570 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262079AbSIYTVh>;
	Wed, 25 Sep 2002 15:21:37 -0400
Date: Wed, 25 Sep 2002 21:34:59 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: cmpxchg in 2.5.38
In-Reply-To: <20020925134215.A17831@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0209252134340.17577-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Sep 2002, Pete Zaitcev wrote:

> OK, I'll work around the cmpxchg locally.

no need, i already sent a patch that removes the cmpxchg.

	Ingo

