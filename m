Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129859AbQLOQnf>; Fri, 15 Dec 2000 11:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbQLOQnZ>; Fri, 15 Dec 2000 11:43:25 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:34452 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S130229AbQLOQnR>;
	Fri, 15 Dec 2000 11:43:17 -0500
Date: Fri, 15 Dec 2000 11:12:20 -0500
Message-Id: <200012151612.LAA11746@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: michael@linuxmagic.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: Alan Cox's message of Fri, 15 Dec 2000 01:09:29 +0000 (GMT),
	<E146jNL-0000SN-00@the-village.bc.nu>
Subject: Re: Signal 11
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Fri, 15 Dec 2000 01:09:29 +0000 (GMT)
   From: Alan Cox <alan@lxorguk.ukuu.org.uk>

   > > o	We tell vendors to build RPMv3 , glibc 2.1.x
   > Curious HOW do you tell vendors??

   When they ask. More usefully Dan Quinlann and most vendors put together a
   recommended set of things to build with and use. It warns about library
   pitfalls, kernel changes and what packaging is supported. It is far from
   perfect and nothing like the LSB goals but its a start and following it does
   give you applications that with a bit of care run on everything.

In the interests of making sure everyone understands the history:

The Linux Development Platform Specification (LDPS) was started as a
result of an informal evening post-LSB-meeting gathering in June --- to
which by the way Red Hat didn't send any representatives(*) --- the
discussion at the restaurant started along the lines of "Oh, my *GOD*
RedHat is about to do something stupid --- they're releasing Red Hat 7.0
with beta/snapshots of just about every single critical system component
except the kernel --- and vendors who fall into the trap developing
against Red Hat 7.0 won't work with any other distribution.  This is
going to be *bad* for Linux."

So yes, the reason why LDPS was formed was to recommend to vendors what
they should build and use --- but while Alan gave comments about the
LDPS once it was announced that a group of people were working on the
LDPS , there is no way that the LDPS could even vaguely be considered a
Red Hat initiative.  (The LDPS is a separate work group which is part of
the FSG, so it is a sister group to the LSB effort.)

							- Ted

(*) Ever since Jim Kingdon left Red Hat (he was at VA Linux for a while,
and is now at SGI), as far as I know no one at Red Hat is actively
participating in the LSB activities --- they haven't sent anyone to the
physical LSB meetings, or participated in the bi-weekly phone
conferences, or taken work items to help finish the LSB.  Alan does
participate on the mailing lists, and makes quite helpful comments, but
as far as I know that's about the limit to Red Hat's participation to
either the LSB or the LDPS specification work.  Speaking as someone who
has been contributing time and effort to the LSB, it would be great if
Red Hat were to become more fully involved in the LSB; I (and I'm sure
all the other LSB volunteers) would welcome a greater level of
participation by Red Hat.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
