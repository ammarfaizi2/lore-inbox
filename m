Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129100AbQJ3Jtj>; Mon, 30 Oct 2000 04:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129110AbQJ3Jta>; Mon, 30 Oct 2000 04:49:30 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:22790 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129100AbQJ3JtU>; Mon, 30 Oct 2000 04:49:20 -0500
Date: Mon, 30 Oct 2000 02:45:57 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030024557.D20102@vger.timpanogas.org>
In-Reply-To: <20001030023339.A20102@vger.timpanogas.org> <Pine.LNX.4.21.0010301155120.3186-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010301155120.3186-100000@elte.hu>; from mingo@elte.hu on Mon, Oct 30, 2000 at 11:56:06AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 11:56:06AM +0100, Ingo Molnar wrote:
> 
> On Mon, 30 Oct 2000, Jeff V. Merkey wrote:
> 
> > > reads dominate writes in almost all workloads, thats common wisdom. Why
> > > write if nobody reads the data? And while web servers are mostly read only
> > > data, they can write data as well, see POST and PUT. The fact that
> > > incoming writes are hard should not let you distract from the fact that
> > > reads are also extremely important.
> >
> > Web servers don't do writes, unless a CGI script is running somewhere
> > or some Java or Perl or something, then this stuff goes through a
> > wrapper, which is slow, or did I miss something.
> 
> yes, you missed TUX modules.
> 


Great.  I can load a TUX module and use it with my T1 line.  If I could
spare an extra $100,000/month, perhaps I can lease an SDM-172 or TAT-8, or
even an OC-172 then I would be able to take advantage of it in the real
world.

Jeff


> 	Ingo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
