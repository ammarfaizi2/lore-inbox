Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264391AbRFGKnm>; Thu, 7 Jun 2001 06:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264390AbRFGKnd>; Thu, 7 Jun 2001 06:43:33 -0400
Received: from innominate.intercity.it ([151.39.132.18]:30964 "HELO ashland")
	by vger.kernel.org with SMTP id <S264392AbRFGKnR>;
	Thu, 7 Jun 2001 06:43:17 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: gurre@start.no (Harald Arnesen), jamagallon@able.es (J . A . Magallon),
        linux-kernel@vger.kernel.org
Subject: Re: temperature standard - global config option?
In-Reply-To: <E157kUn-0000Rd-00@the-village.bc.nu>
From: davidw@apache.org (David N. Welton)
Date: 07 Jun 2001 12:43:12 +0200
Message-ID: <874rtsmuyn.fsf@apache.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > Absolutely. We chide Microsoft for not following standards, so we
> > should definitely follow the SI standards, which are much firmer
> > than any internet standards.

> /dev/temperature is in farenheit. It was specified by someone in the
> UK several years ago and we are stuck with it that way really.

So it is not possible to have an 'opt-in' kernel config (or sysctl, I
suppose) option (default is off) that allows you to say "ok, on this
box, everything is going to be in Fahrenheit/Celsius/Kelvin"?  It
would be something that the admin decides to turn on, hopefully
conscious of the fact that this may entail other changes.
 
> Newer API's should probably use celcius/kelvin

My thought was that it would be nice to be able to configure this, so
that one could work with the units one is most comfortable with.  104
Fahrenheit tells *me* a lot more than 313 Kelvin.  Maybe Elbonians are
more comfortable working with Kelvin.

Well, anyway, it was just an idea that popped into my head when
looking around, I'll step aside and let you guys figure out what is
best:-) (Please do keep me CC'ed though).

Thankyou for your time,
-- 
David N. Welton
Free Software: http://people.debian.org/~davidw/
   Apache Tcl: http://tcl.apache.org/
     Personal: http://www.efn.org/~davidw/
         Work: http://www.innominate.com/
