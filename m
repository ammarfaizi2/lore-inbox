Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129386AbQKAR3s>; Wed, 1 Nov 2000 12:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129253AbQKAR3i>; Wed, 1 Nov 2000 12:29:38 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:16653 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129157AbQKAR3Z>; Wed, 1 Nov 2000 12:29:25 -0500
Message-ID: <3A005217.88D2CA0D@timpanogas.org>
Date: Wed, 01 Nov 2000 10:25:43 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <E13qj56-0003h9-00@pmenage-dt.ensim.com> <39FF3D53.C46EB1A8@timpanogas.org> <20001031140534.A22819@work.bitmover.com> <39FF4488.83B6C1CE@timpanogas.org> <20001031142733.A23516@work.bitmover.com> <39FF49C8.475C2EA7@timpanogas.org> <20001101023010.G13422@athlon.random> <20001031183809.C9733@.timpanogas.org> <20001101164106.F9774@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:
> 
> On Tue, Oct 31, 2000 at 06:38:09PM -0700, Jeff V. Merkey wrote:
> > [..] It's all rather complicated, and I think alien
> > to Unix folks. [..]
> 
> That has _nothing_ to do with software. That's only has to do with the IA32
> hardware.
> 
> If you only switch the stack during context switching then you _can't_ provide
> memory protection between different tasks. Period.
> 

Andrea,

I am writing up a complete description of NetWare internals, and what we
are doing to 
the 2.2.X code base to create a NetWare Linux hybrid.  I will post, an
if Alan wants to fork his own personal NetWare 2.2.18pre in his /people
area, I would have Andre and my folks maintain it and make it available
for everyone to use.  

I've been deluged with emails from folks on the list telling me to go
for it, and Novell customers who think it's a valid path to preserve
their investments in Novell technologies, and I know it will be a
lucrative market and put Linux in high level enterprise accounts for
high capacity file and print.  When 2.4 is out the door, we'll start
looking at that one.

It would also allow the Linux companies to go from 20 million a year in
revenues to 100 million in revenues on boxed software sales alone. 
Novell is bringing in 1 billion dollars a year.  If Caldera, Suse, and
RedHat split this three ways, that's 33 million dollars more each year
than they are making now.  People will pay it, and since it's ring 0,
they have to get it from a vendor to know that all the componenets are
stable together (this is how Novell stays in the accounts and is able to
deamdn a high price for this product).

I am finishing NWFS 2.4.4 post so, I will finish the write up after I
finish up these auto repair tools for the FS.

:-)

Jeff


> Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
