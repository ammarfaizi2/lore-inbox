Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281645AbRLDSWD>; Tue, 4 Dec 2001 13:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283203AbRLDSUa>; Tue, 4 Dec 2001 13:20:30 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:44169 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S283119AbRLDSTl>; Tue, 4 Dec 2001 13:19:41 -0500
To: esr@thyrsus.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Cc: linux-kernel@vger.kernel.org
Message-Id: <E16BKL5-0001yJ-00@DervishD.viadomus.com>
Date: Tue, 4 Dec 2001 19:30:43 +0100
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <raul@viadomus.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Eric :))

>(2) Requiring Python introduces another tool into the requisites list for
>kernel building.  

    I'm happy to see that out of your 'silly' list...

>I'm just going to say "Today's problems, today's tools."

    Hey, hope that Python never gets considered a 'today's tool' or
we will end up needing 256 CPU mainframes just to issue an 'ls'
(maybe this will not be enough if filesystem drivers are written in
Python too. In the future, I mean...).

    And yes, Python is a today's problem. Fortunately, people keeps
rewriting their Python code in true languages.

>Progress happens.

    Python is not progress, is just bloatware. I don't think that the
kernel *building* should be made dependant on such a fatware. And,
how about the 'Python License'. I'm pretty sure that it is compatible
with the rest of the kernel, but we should pray for it not to change.

    And, well, Python is fatware just for me: anyway will see
reasonable to install a 6Mb sources language just for the
configuration of the kernel. Very reasonable.

>If you don't like it, feel free to go back to writing Autocoder on your 1401.

    Good policy... People who don't like Python are morons... And
maybe those that neither use Java or C# for the kernel will be too in
a near future, is that what you're trying to say?

    Eric, I think that this is an important issue and that the
decision about adding such a big dependence to the kernel should be
studied with care, and not imposed.

    Raúl
