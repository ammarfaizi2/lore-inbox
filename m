Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129873AbQLOKzP>; Fri, 15 Dec 2000 05:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130343AbQLOKzF>; Fri, 15 Dec 2000 05:55:05 -0500
Received: from anakin.xinit.se ([194.14.168.3]:47888 "HELO anakin.xinit.se")
	by vger.kernel.org with SMTP id <S130335AbQLOKyt>;
	Fri, 15 Dec 2000 05:54:49 -0500
Message-ID: <3A39F1AF.88D1FEA0@arrowhead.se>
Date: Fri, 15 Dec 2000 11:25:51 +0100
From: josef höök <josef.hook@arrowhead.se>
Organization: Arrowhead
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.GSO.4.21.0012132050140.6300-100000@weyl.math.psu.edu> <Pine.LNX.4.21.0012132043350.24483-100000@www.nondot.org> <20001214210245.B468@bug.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> Hi!
>
> > For one of our demos, we ran a file server on a remote linux box (that we
> > just had a user account on), mounted it on a kORBit'ized box, and ran
> > programs on SPARC Solaris that accessed the kORBit'ized linux box's file
> > syscalls.  If nothing else, it's pretty nifty what you can do in little
> > code...
>
> Cool!
>
> However, can you do one test for me? Do _heavy_ writes on kORBit-ized
> box. That might show you some problems. Oh, and try to eat atomic
> memory by ping -f kORBit-ized box.
>
> I've always wanted to do this: redirect /dev/dsp from one machine to
> another. (Like, I have development machine and old 386. I want all
> programs on devel machine use soundcard from 386. Can you do that?)
>
>                                                                 Pavel
>

In Plan9 you can.
/joh



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
