Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132223AbRCaDzq>; Fri, 30 Mar 2001 22:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132220AbRCaDzh>; Fri, 30 Mar 2001 22:55:37 -0500
Received: from twin.uoregon.edu ([128.223.214.27]:55942 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id <S132219AbRCaDz0>;
	Fri, 30 Mar 2001 22:55:26 -0500
Date: Fri, 30 Mar 2001 19:54:44 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
To: "Hen, Shmulik" <shmulik.hen@intel.com>
cc: <linux-kernel@vger.kernel.org>, "'LNML'" <linux-net@vger.kernel.org>
Subject: RE: Plans for 2.5
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B271A4@hasmsx52.iil.intel.com>
Message-ID: <Pine.LNX.4.30.0103301941431.29402-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2001, Hen, Shmulik wrote:

> Just some general questions:
>
> 1) Is there anywhere a list that describes what is intended to be in 2.5.x ?
> 2) Are there any early releases of 2.5.x ?

if it's anything like 2.1 or 2.3 we need a bit more 2.4 tidying till
somebody decides some major component needs a rewrite.

> 3) Are the things for 2.5.x being discussed on another mailing list ?
> 4) What is the time frame of releasing 2.5.x-final (or 2.6.x) ?

wow that's jumping the gun a bit.

> Specifically, I'm more interested in the network driver aspect.
> 1) Are there any intended changes to the networking layer ?

I should think.

> 2) I over heard something about making the driver reentrant - any news ?
> 3) What about support for IPv6 ? (I noticed it was marked as experimental
> until now)

one of things I'd like to see is igmpv3 support. The sprintlabs code would
need pretty serious effort to make pretty, but folks are starting to work
on getting wilberts (kpn) code into freebsd 4.3 beta so it might be time
to start looking at it.

>
> 	Thanks in advance,
> 	Shmulik Hen
>       Software Engineer
> 	Linux Advanced Networking Services
> 	Intel Network Communications Group
> 	Jerusalem, Israel
>
>
> -----Original Message-----
> From: Bruno Avila [mailto:jisla@elogica.com.br]
> Sent: Thursday, March 29, 2001 12:45 AM
> To: linux-kernel@vger.kernel.org
> Subject: Plans for 2.5
>
>
> Hello people,
>
> 	I got some questions. When are we going to develop stuff for 2.5?
> What is
> planed? My opinion for linux 2.5 should be performance. Since linux already
> is stable or well done for nature, we could thing more on performance to be
> a diferencial over others. What do you people thing?
>
>                                               Bruno Avila
>
> PS: Not a good english. I know! :)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.



