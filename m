Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131221AbRCXAS5>; Fri, 23 Mar 2001 19:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131339AbRCXASs>; Fri, 23 Mar 2001 19:18:48 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:30727 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131221AbRCXASe>; Fri, 23 Mar 2001 19:18:34 -0500
Date: Thu, 22 Mar 2001 21:52:15 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: linux-kernel@vger.kernel.org, lwn@lwn.net
Cc: jgarzik@mandrakesoft.com, Andrey Panin <pazke@orbita.don.sitek.net>,
        Hans Grobler <grobh@sun.ac.za>, Andrew Morton <andrewm@uow.edu.au>,
        Rasmus Andersen <rasmus@jaquet.dk>
Subject: [ANNOUNCE] The Janitor Project
Message-ID: <20010322215215.A1052@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	linux-kernel@vger.kernel.org, lwn@lwn.net, jgarzik@mandrakesoft.com,
	Andrey Panin <pazke@orbita.don.sitek.net>,
	Hans Grobler <grobh@sun.ac.za>, Andrew Morton <andrewm@uow.edu.au>,
	Rasmus Andersen <rasmus@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Kernel Janitor's Project grew out of our search for things to help in
the development of the Linux kernel, and learning from other patches
submitted by more experienced people, we saw that some of these patches
indicated error patterns that could exist in other parts of the kernel, we
looked and... yes, we discovered that some parts of the kernel suffered
from the same problems and in the process we found code bitrotting...

I (acme) started maintaining a TODO list for things to fix or clean up and
people started submitting suggestions for things to fix that I collected at
http://bazar.conectiva.com.br/~acme/TODO, looking at the httpd logs I
discovered that _lots_ of people accessed it, so this indeed was something
useful as a starting point for people also wanting to help in cleaning
up/fixing parts of the kernel.

Now we're expanding this so that this continues to be useful, hosting it at
sourceforge to make possible for other people to include more things to
clean/fix.

So, get your broom and start cleaning! 8)

regards,

The kernel-Janitor team.

-------------------------------------------------------------------------
One anouncement is not enough, so here's another one 8)
-------------------------------------------------------------------------

The kernel janitor project has been created at
http://www.sourceforge.net/projects/kernel-janitor

Acme's TODO list is now held there in CVS, and there are also mailing lists
announcing new addtions, and another for discussion.

This project does not replace, but instead compliments the existing janitor
list maintained by Acme.  By keeping this in CVS with multiple maintainers,
updates will happen more frequently.

The mailing list will contain many discussions of patches fixing problems
on the TODO, and also explanations of how these things can be fixed.

regards,

The kernel-Janitor team.
-------------------------------------------------------------------------

And yes, the Stanford team work is helping to make the TODO bigger 8)
