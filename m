Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285184AbRLRVaE>; Tue, 18 Dec 2001 16:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285180AbRLRV2S>; Tue, 18 Dec 2001 16:28:18 -0500
Received: from cs182072.pp.htv.fi ([213.243.182.72]:19584 "EHLO
	cs182072.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S285179AbRLRV1g>; Tue, 18 Dec 2001 16:27:36 -0500
Message-ID: <3C1FB4AF.486B4AC4@welho.com>
Date: Tue, 18 Dec 2001 23:27:11 +0200
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: rmk@arm.linux.org.uk, kuznet@ms2.inr.ac.ru, Mika.Liljeberg@nokia.com,
        linux-kernel@vger.kernel.org, sarolaht@cs.helsinki.fi
Subject: Re: ARM: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
In-Reply-To: <20011218210332.D13126@flint.arm.linux.org.uk>
		<20011218.131155.91757544.davem@redhat.com>
		<20011218211450.E13126@flint.arm.linux.org.uk> <20011218.131554.84359165.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> If it was "your problem, so go away" why did I even bother posting a
> patch for him to test out?

Whoa, chill fellas! I didn't mean to start a flame war. :-|

I'll give your patch a go, although seeing that the platform takes care
of the alignment problem, the real bug is probably elsewhere.

	MikaL
