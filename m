Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272273AbRHXR3x>; Fri, 24 Aug 2001 13:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272278AbRHXR3n>; Fri, 24 Aug 2001 13:29:43 -0400
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:33799 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S272273AbRHXR3c>; Fri, 24 Aug 2001 13:29:32 -0400
To: "Samium Gromoff" <_deepfire@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: source control?
In-Reply-To: <E15aKdG-000KU2-00@f12.port.ru>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 24 Aug 2001 19:29:39 +0200
In-Reply-To: <E15aKdG-000KU2-00@f12.port.ru> ("Samium Gromoff"'s message of "Fri, 24 Aug 2001 21:20:34 +0400")
Message-ID: <tgu1yxicxo.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Samium Gromoff" <_deepfire@mail.ru> writes:

> > > That's a great description of all source control!  "Makes it all to easy
> > > for other people to push crap into your tree"!
> 
> > Try Aegis.  It enforces a develop/review/integrate cycle for each
> > change.

>   and slows down the things...

Well, sometimes this increases productivity. ;-)

>   and hides (though not completely) the process from the people...

Well, if everyone has to monitor every other developer, there would be
problems, too.

>   one-thread-modify of some piece of code is inefficeient.

Of course, Aegis supports multiple changes which are being developed
at the same time.

>     When X code hacker splits his changes on small pieces
>   and feeds them to Linus^WSourceControl, does he need
>   to move each of his patches thru these
>   develop/review/integrate cycles?

IIRC, some time in the past, Linus said that he was the integrator and
the subsystem maintainers the reviewers.  I think the Linux
development process is actually pretty close to the Aegis model.
(However, the Aegis implementation seems to have some properties which
make it a bit unsuitable for controlling the Linux kernel
development.)

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
