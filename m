Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290047AbSAWUbO>; Wed, 23 Jan 2002 15:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290048AbSAWUbF>; Wed, 23 Jan 2002 15:31:05 -0500
Received: from mx2.elte.hu ([157.181.151.9]:8320 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290047AbSAWUaz>;
	Wed, 23 Jan 2002 15:30:55 -0500
Date: Wed, 23 Jan 2002 23:28:24 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Zdenek Smetana <zdenek@smetana.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Missing changelog to Ingo's J5 scheduler?
In-Reply-To: <20020123135252.A58419@skuter.storm.com.pl>
Message-ID: <Pine.LNX.4.33.0201232324550.14887-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Jan 2002, Zdenek Smetana wrote:

> I can't find it.

J5 is the next step towards better interactiveness. Lowered the default
timeslice length from 250 msecs to 150 msecs - long timeslices were
clearly causing problems for certain applications.

there are some changes in my tree that will be -J6, will write a fuller
changelog, there are cleanups from other people included as well.

	Ingo

