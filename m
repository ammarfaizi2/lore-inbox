Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283286AbRLDTzV>; Tue, 4 Dec 2001 14:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283388AbRLDTyP>; Tue, 4 Dec 2001 14:54:15 -0500
Received: from [206.98.161.198] ([206.98.161.198]:47886 "EHLO
	bart.learningpatterns.com") by vger.kernel.org with ESMTP
	id <S283218AbRLDTws> convert rfc822-to-8bit; Tue, 4 Dec 2001 14:52:48 -0500
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
From: Edward Muller <emuller@learningpatterns.com>
To: =?ISO-8859-1?Q?Ra=FAlN=FA=F1ez?= de Arenas Coronado 
	<raul@viadomus.com>
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org
In-Reply-To: <E16BKL5-0001yJ-00@DervishD.viadomus.com>
In-Reply-To: <E16BKL5-0001yJ-00@DervishD.viadomus.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 04 Dec 2001 14:50:52 -0500
Message-Id: <1007495452.4621.7.camel@akira.learningpatterns.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm just sick of people saying that python is bloated.

I've put python on my Compaq IPAQ (running linux) and with very few
amounts of tweaks it took up less 1 MB. And that's including gtk
bindings (no tk though) and just about the entire standard python
library. Someone else tried to do this with perl and they couldn't get
it under 3 MB IIRC. And IIRC, the current kernel build system requires
perl (I could be wrong, I'm just a watcher on this list, not a hacker).
So ... PYTHON IS NOT BLOATED.

Python maybe slow (when compared to C/C++ code). But that is the nature
of an interpreted language. Python's speed is on par with Perl's and
most other interpreted languages.

Anyway ... I'm done venting.

On Tue, 2001-12-04 at 13:30, RaúlNúñez de Arenas Coronado wrote:
>     Hi Eric :))
> 
> >(2) Requiring Python introduces another tool into the requisites list for
> >kernel building.  
> 
>     I'm happy to see that out of your 'silly' list...
> 
> >I'm just going to say "Today's problems, today's tools."
> 
>     Hey, hope that Python never gets considered a 'today's tool' or
> we will end up needing 256 CPU mainframes just to issue an 'ls'
> (maybe this will not be enough if filesystem drivers are written in
> Python too. In the future, I mean...).
> 
>     And yes, Python is a today's problem. Fortunately, people keeps
> rewriting their Python code in true languages.
> 
> >Progress happens.
> 
>     Python is not progress, is just bloatware. I don't think that the
> kernel *building* should be made dependant on such a fatware. And,
> how about the 'Python License'. I'm pretty sure that it is compatible
> with the rest of the kernel, but we should pray for it not to change.
> 
>     And, well, Python is fatware just for me: anyway will see
> reasonable to install a 6Mb sources language just for the
> configuration of the kernel. Very reasonable.
> 
> >If you don't like it, feel free to go back to writing Autocoder on your 1401.
> 
>     Good policy... People who don't like Python are morons... And
> maybe those that neither use Java or C# for the kernel will be too in
> a near future, is that what you're trying to say?
> 
>     Eric, I think that this is an important issue and that the
> decision about adding such a big dependence to the kernel should be
> studied with care, and not imposed.
> 
>     Raúl
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
-------------------------------
Edward Muller
Director of IS

973-715-0230 (cell)
212-487-9064 x115 (NYC)

http://www.learningpatterns.com
-------------------------------

