Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278690AbRK0Nb4>; Tue, 27 Nov 2001 08:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279201AbRK0Nbq>; Tue, 27 Nov 2001 08:31:46 -0500
Received: from mx2.elte.hu ([157.181.151.9]:9703 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S278690AbRK0Nbb>;
	Tue, 27 Nov 2001 08:31:31 -0500
Date: Tue, 27 Nov 2001 16:28:49 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Rusty <rusty@rustcorp.com.au>
Subject: Re: smp_call_function & BH handlers
In-Reply-To: <20011127185739.H14200@in.ibm.com>
Message-ID: <Pine.LNX.4.33.0111271626170.17811-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Nov 2001, Maneesh Soni wrote:

> Why is it ok to call smp_call_function from bottom half handlers? [...]

which part of the kernel is calling smp_call_function() from bh contexts?

	Ingo

