Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbQJaG7U>; Tue, 31 Oct 2000 01:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129273AbQJaG7K>; Tue, 31 Oct 2000 01:59:10 -0500
Received: from chiara.elte.hu ([157.181.150.200]:21511 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129159AbQJaG7A>;
	Tue, 31 Oct 2000 01:59:00 -0500
Date: Tue, 31 Oct 2000 09:08:47 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <39FDB6ED.FAFDBEEB@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0010310847430.1075-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2000, Jeff V. Merkey wrote:

> Ingo's helping me get the info together on this for putting a MARS-NWE
> tux module in the kernel. [...]

TUX modules are user-space, so i certainly cannot help you in 'putting
MARS-NWE in the kernel'. While you (apparently) are trying to move server
applications into ring0, i agree with Andrea and i'm trying to move kernel
functionality out to user-space.

> He had to go do some things this week he told me before he would be
> ready to look at it. He did point me over to the info, and I agreed we
> would attempt to implement it as something to look at. If it performs
> well enough, I will have something reasonable to send out to Novell
> Resellers (CNEs) and Cutomers.

All i did was to inform you that the next release of TUX is imminent and
that you might want to take a look at the new code. You interpreted that
in a very interesting way. You are certainly free and welcome to take a
look at any code and documentation released, but as visible in the past
couple of email exchanges, our technical views about Linux networking
scalability differ in fundamental ways.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
