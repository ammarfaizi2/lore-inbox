Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132428AbRDUCbw>; Fri, 20 Apr 2001 22:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132429AbRDUCbl>; Fri, 20 Apr 2001 22:31:41 -0400
Received: from smtp.mountain.net ([198.77.1.35]:34571 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S132428AbRDUCb3>;
	Fri, 20 Apr 2001 22:31:29 -0400
Message-ID: <3AE0F0CA.EE16AB3D@mountain.net>
Date: Fri, 20 Apr 2001 22:30:34 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: lee@ricis.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Current status of NTFS support
In-Reply-To: <86256A34.0079A841.00@smtpnotes.altec.com> <01042020185806.00845@linux> <m34rvjuj3y.fsf@belphigor.mcnaught.org> <01042021072007.00845@linux>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Leahu wrote:
> 
> On Friday 20 April 2001 20:39, you wrote:
> > Lee Leahu <lee@ricis.com> writes:
> > > would somebody be kind enough to explain why writing to
> > > the ntfs file system is extremely dangerous,  and what are the
> > > developers doing to make writing to ntfs filesystem safe?
> >
> > It's dangerous because NTFS is a proprietary format, and the full
> > rules for updating it (including journals etc) are known only to
> > Microsoft and those that have signed Microsoft NDAs.  If you update it
> > incorrectly it gets corrupted and you will lose data.  It's certainly
> > possible to reverse-engineer these rules, but very difficult and
> > time-consuming.
> >
> > -Doug
> 
> my boss rememebres reading a very indepth article in one of the msdn
> magazines.  i could scan the articles in and compress them and send them to
> the developers. i want to help the ntfs movement on linux.  would somebody be
> willing to teach me the ropes of reverse engineering of software.  i am a
> faster learner, and very interested in reverse engineering of software.

Copyright interferes with that route, and I'm sure Microsoft would be happy
to
enforce that. Links to the msdn.microsoft.com library/kb articles would be
good.

> i have access to the msdn library and maganzies and have lot of free time for
> dedicated ntfs code hacking.

Also good.

Cheers,
Tom
-- 
The Daemons lurk and are dumb. -- Emerson
