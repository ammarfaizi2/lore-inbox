Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289750AbSAOOXV>; Tue, 15 Jan 2002 09:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289573AbSAOOXL>; Tue, 15 Jan 2002 09:23:11 -0500
Received: from mx2.elte.hu ([157.181.151.9]:5542 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289733AbSAOOXB>;
	Tue, 15 Jan 2002 09:23:01 -0500
Date: Tue, 15 Jan 2002 17:20:28 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [patch] O(1) scheduler, 2.4.17-I0
Message-ID: <Pine.LNX.4.33.0201151718360.10830-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the 2.4.17-I0 O(1) scheduler patch is available at:

    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-I0.patch

this is a backport of the 2.5.2+I0 O(1) scheduler code.

	Ingo


