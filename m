Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317677AbSGUOYh>; Sun, 21 Jul 2002 10:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317689AbSGUOYh>; Sun, 21 Jul 2002 10:24:37 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37536 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317677AbSGUOYg>;
	Sun, 21 Jul 2002 10:24:36 -0400
Date: Sun, 21 Jul 2002 16:26:17 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: anton wilson <anton.wilson@camotion.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 O(1) scheduler
In-Reply-To: <200207191943.PAA00351@test-area.com>
Message-ID: <Pine.LNX.4.44.0207211624580.12365-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Jul 2002, anton wilson wrote:

> I'm working on a project that uses the O(1) scheduler and I am forced to
> use a 2.4 kernel for time issues. Will the O(1) patches for 2.4 kernels
> be updated once the 2.5.26+ patch becomes stable?

you can find the latest 2.4 based O(1) scheduler patch at:

  http://redhat.com/~mingo/O(1)-scheduler/sched-2.4.19-rc2-A4

this patch includes the load_balance() fixes as well. (generally you
should check this directory regularly, sometimes i put out patches without
announcing them - like this one.)

	Ingo

