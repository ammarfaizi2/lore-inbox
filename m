Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292456AbSBPRaa>; Sat, 16 Feb 2002 12:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292458AbSBPRaU>; Sat, 16 Feb 2002 12:30:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62213 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292456AbSBPRaL>;
	Sat, 16 Feb 2002 12:30:11 -0500
Message-ID: <3C6E9717.86D66D54@mandrakesoft.com>
Date: Sat, 16 Feb 2002 12:29:59 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Possible breakthrough in the CML2 logjam?
In-Reply-To: <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215213833.J27880@suse.de> <1013810923.807.1055.camel@phantasy> <20020215232832.N27880@suse.de> <3C6DE87C.FA96D1D6@mandrakesoft.com> <20020216095202.M23546@thyrsus.com> <3C6E7C75.A6659D72@mandrakesoft.com> <20020216105219.A31001@thyrsus.com> <3C6E8A15.D5C209B1@mandrakesoft.com> <20020216115739.B32311@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> But if "eliminate global depencies" is it, we can be allies, because
> ultimately we both want to get the config system to the same place.
> I've taken the first, biggest step -- from imperative code to
> declaration/constraint language.  The second -- from a
> declaration/constraint language to a metadata-centered system --
> will be easier.

Well, let's simmer things down a bit and see what other people have to
say.  Maybe I'm completely off base.

But to answer the question which the subtext seemed to asking (at least
to me), no, there is no vendetta against you.  And for the record on a
specific detail, I have no problem with python use.  If I have no major
objection based purely on technical grounds, that what you'll be hearing
from me.

And further, in 2.5.x series at least, minor objections can be worked
through after a kernel merge.  But major objections... that's not the
time when something -must- -go- -in-.

Regards,

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
