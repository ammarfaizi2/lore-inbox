Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129179AbQJ3KAA>; Mon, 30 Oct 2000 05:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129300AbQJ3J7u>; Mon, 30 Oct 2000 04:59:50 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:26374 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129179AbQJ3J7i>; Mon, 30 Oct 2000 04:59:38 -0500
Date: Mon, 30 Oct 2000 02:56:00 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030025600.B20271@vger.timpanogas.org>
In-Reply-To: <20001030023339.A20102@vger.timpanogas.org> <Pine.LNX.4.21.0010301150390.3186-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010301150390.3186-100000@elte.hu>; from mingo@elte.hu on Mon, Oct 30, 2000 at 12:04:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 12:04:43PM +0100, Ingo Molnar wrote:
> 
> On Mon, 30 Oct 2000, Jeff V. Merkey wrote:
> 
> > It's not curious, it's not about bandwidth, it's about latency, and
> > getting packets in and out of the server as fast as possible, and
> > ahead of everything else. [...]
> 
> TUX prepares a HTTP reply in about 30 microseconds (plus network latency),
> good enough? Network latency is the limit, even on gigabit - not to talk
> about T1 lines.

Great.  Now how do we get the smae numbers on SAMBA and MARS-NWE?   THat's 
the question, not whether your baby TUX is pretty.  I already said it
was pretty, focus on the other issue.

Jeff

> 
> 	Ingo
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
