Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289729AbSAOXFr>; Tue, 15 Jan 2002 18:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289824AbSAOXFh>; Tue, 15 Jan 2002 18:05:37 -0500
Received: from mx2.elte.hu ([157.181.151.9]:39855 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289729AbSAOXF1>;
	Tue, 15 Jan 2002 18:05:27 -0500
Date: Wed, 16 Jan 2002 02:02:53 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: davidel <davidel@xmailserver.org>, torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -I1
In-Reply-To: <20020115.234823.884032698.rene.rebe@gmx.net>
Message-ID: <Pine.LNX.4.33.0201160159550.25703-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Jan 2002, Rene Rebe wrote:

> I just tried the sched-O1-2.4.17-I0.patch and interactive performance
> is unbelieveable bad!

this must be a 2.4-specific problem, i have no such problem under
2.5.3+I3. The 2.4 patch is less tested and there might be merging errors
in it. Please wait for the 2.4 -I3 patch.

	Ingo

