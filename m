Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129290AbQJ3KEU>; Mon, 30 Oct 2000 05:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129330AbQJ3KEK>; Mon, 30 Oct 2000 05:04:10 -0500
Received: from chiara.elte.hu ([157.181.150.200]:52486 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129290AbQJ3KED>;
	Mon, 30 Oct 2000 05:04:03 -0500
Date: Mon, 30 Oct 2000 12:13:52 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030025600.B20271@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0010301212590.3186-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2000, Jeff V. Merkey wrote:

> > TUX prepares a HTTP reply in about 30 microseconds (plus network latency),
> > good enough? Network latency is the limit, even on gigabit - not to talk
> > about T1 lines.
> 
> Great.  Now how do we get the smae numbers on SAMBA and MARS-NWE? [...]

simple, write a TUX protocol module for it. FTP protocol module is on its
way. Stay tuned.
 
	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
