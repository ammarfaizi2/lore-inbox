Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286365AbRLTU0x>; Thu, 20 Dec 2001 15:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286364AbRLTU0p>; Thu, 20 Dec 2001 15:26:45 -0500
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:8964 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S286368AbRLTU0d>; Thu, 20 Dec 2001 15:26:33 -0500
Subject: Re: Configure.help editorial policy
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011220143247.A19377@thyrsus.com>
In-Reply-To: <20011220143247.A19377@thyrsus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 20 Dec 2001 14:27:02 -0600
Message-Id: <1008880024.3926.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-12-20 at 13:32, Eric S. Raymond wrote:
> I am by no means in love with the new abbreviations described at
> <http://physics.nist.gov/cuu/Units/binary.html>.  I have the same 
> reflexes as the rest of you -- they kind of make me want to gag.

I second that emotion.

> If there is a clear consensus from lkml, I will be happy to back
> out this change.  Perhaps this terminological standard does not
> meet a real need, perhaps it will be rejected by most engineers and 
> deserves to wither on the vine.  It's happened before.

I'd vote for that.

> However.  In the *absence* of a clear consensus, I will follow best
> practices.  Best practice in editing a technical or standards document
> is to (a) avoid ambiguous usages, seek clarity and precision; and (b)
> to use, follow and reference international standards.

Perhaps if we could be so bold as to back Donald Knuth's KKB,MMB,GGB
proposal (of which I learned here:
http://www.linuxdoc.org/HOWTO/Large-Disk-HOWTO-3.html ). I understand
that muddying the waters is not the way to see clearly into the depths
of computer science for the unwashed masses, but the ambiguity that
currently exists is very real. I try to explain these issues on what
seems like a daily basis to many and the duplicitous terms are not
helpful.
 
> My personal esthetic distaste for the new terminology (gack!  "kibi" 
> sounds like something I would feed my cat!) is less important
> than following best practices.  I'm hoping it will seem less ugly as it
> becomes more familiar.

It certainly rated high on my kibbles'n'bits meter as well :-)

Whatever we do with the abbreviations, I would strongly recommend we
spell out documention to help educate ( and ease the transition if we
switch terms) wherever possible. For example:

4 binary kilobyte pages
1024 decimal kilobyte disk
8.4 decimal gigabyte disks
4 binary gigabytes of memory
10 decimal gigabits of bandwith

or if that offends the sensibilities:

4 kilobytes (binary)
1024 kilobytes (decimal)
8.4 gigabytes (decimal)

I know that they are long on keystrokes, but in lieu of an accepted and
aesthetically pleasing standard, they are clear and unambiguous.
 
Regards,
Reid
--
Protect your rights, Geeks with Guns!

