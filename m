Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWBNBE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWBNBE7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 20:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWBNBE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 20:04:59 -0500
Received: from host.atlantavirtual.com ([209.239.35.47]:18622 "EHLO
	host.atlantavirtual.com") by vger.kernel.org with ESMTP
	id S1030285AbWBNBE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 20:04:58 -0500
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
From: kernel <kernel@crazytrain.com>
Reply-To: kernel@crazytrain.com
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jerome.lacoste@gmail.com, dhazelton@enter.net, peter.read@gmail.com,
       mj@ucw.cz, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
In-Reply-To: <43F08D45.nailKUSE1SA4H@burner>
References: <20060208162828.GA17534@voodoo> <43EC8F22.nailISDL17DJF@burner>
	 <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
	 <200602092241.29294.dhazelton@enter.net>  <43F08D45.nailKUSE1SA4H@burner>
Content-Type: text/plain
Message-Id: <1139879123.3697.16.camel@crazytrain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 13 Feb 2006 20:05:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 08:44, Joerg Schilling wrote:
> Any patch that
> 
> -	does not break things
> 
Good. Makes sense.  Acceptable.


> -	fits into the spirit of the currnt implementation
> 
Bad.  Subject to the gate keeper's ideas, whims, and personal agenda.


> -	offers useful new features
> 
Good.  Makes sense.  Acceptable.


> -	conforms to coding style standards
> 
Good.  Makes sense.  Acceptable.


> -	does not need more time to integrate than I would need to
> 	write this from scratch
Good.  Makes sense.  Acceptable.


To sum, all technical and acceptable points *except* for one.  And of
course, this one is the one that has kept this thread (in various forms)
going for what seems like *years*.

Do you know what's really scary?  The normal users, the managers, the
technical users, etc. who've read LKML and have read this thread (either
in its entirety or partial) (such as myself and my colleagues) who
suddenly pucker when they feel that the fate of writing to CD media in
Linux is in the hands of *one* person.  And this one person projects the
identity of the angry child in the schoolyard who would grab his toys
and walk away to play by himself if everyone else playing the same game
didn't do what he said, when he said, how he said.  People looking into
Linux, perhaps considering investing in it, read this thread and think
"Wow, they can't even get together on CD burning!" (Simplified, I know.)

This is one impression given in this most recent thread pertaining to
this topic.  I cannot believe that somewhere on this planet other
developers don't band together to write something equally as good or
better to end this current nonsense *and* to prevent future hassles with
this current implementation of this program and the developer.  (No, I
don't code, but in instances like this I wish I did.)  I see this thread
and I just keep thinking "Couldn't have it all been solved by now?  How
many lines in this thread versus how many lines of code would it take?"

Please, talented developers, look into writing a similar program that
does fit with the current and planned Linux way and remove reliance on
this unbending individual.  It's a big world.  I've seen other projects
start small and gain momentum and grow.  Y'all are no stranger to this
same phenomenon.  Certainly there are other coders and testers willing
to assist in this project.

And BTW, wouldn't the ultimate salute to Jorg be to never have to endure
another LKML thread like this one because Linux users are using another
bit of code?

regards,
-fd






