Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129082AbQJ3KMV>; Mon, 30 Oct 2000 05:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129138AbQJ3KML>; Mon, 30 Oct 2000 05:12:11 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:30214 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129082AbQJ3KMB>; Mon, 30 Oct 2000 05:12:01 -0500
Date: Mon, 30 Oct 2000 03:08:38 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030030838.D20271@vger.timpanogas.org>
In-Reply-To: <20001030025600.B20271@vger.timpanogas.org> <Pine.LNX.4.21.0010301212590.3186-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010301212590.3186-100000@elte.hu>; from mingo@elte.hu on Mon, Oct 30, 2000 at 12:13:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 12:13:52PM +0100, Ingo Molnar wrote:
> 
> On Mon, 30 Oct 2000, Jeff V. Merkey wrote:
> 
> > > TUX prepares a HTTP reply in about 30 microseconds (plus network latency),
> > > good enough? Network latency is the limit, even on gigabit - not to talk
> > > about T1 lines.
> > 
> > Great.  Now how do we get the smae numbers on SAMBA and MARS-NWE? [...]
> 
> simple, write a TUX protocol module for it. FTP protocol module is on its
> way. Stay tuned.
>  
> 	Ingo


I do not believe this approach will allow Linux to match NetWare's 
file and print performance, but I am willing to give it a whirl.  Where
is the TUX module for MARS.  Let's start with this one.  What help
would you require.  You understand these TUX modules, so you should
take the lead.

I am listening.  Instruct me....


Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
