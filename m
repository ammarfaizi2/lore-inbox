Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292329AbSBPJQb>; Sat, 16 Feb 2002 04:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292330AbSBPJQV>; Sat, 16 Feb 2002 04:16:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13582 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292329AbSBPJQI>;
	Sat, 16 Feb 2002 04:16:08 -0500
Message-ID: <3C6E2355.AA514ECA@mandrakesoft.com>
Date: Sat, 16 Feb 2002 04:16:05 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Giacomo A. Catenazzi" <cate@dplanet.ch>
CC: linux-kernel@vger.kernel.org, kaos@ocs.com.au
Subject: Re: kbuild [which is not only CML2]
In-Reply-To: <3C6E1F90.40404@dplanet.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Giacomo A. Catenazzi" wrote:
> The discussion was also on lkml, ESR asked to kbuild
> people to give some comments, using also the feed-back
> of lkml.
> As you noticed, in lkml the discussion went into flames,
> fogetting the important points.
> [As this flame is going forgetting kbuild-2.5..]]

No need for a huge long e-mail to make a basic point:
Don't lump CML2 and Keith's kbuild work together.

I agree, and this is a good point.


> Tell us what is wrong in kbuild-2-5 and in CML2. Don't flame!

We've been doing that for CML2.  For months, actually.

kbuild (again, as you point out) is quite another matter.  Perhaps we
can point Keith to post a test patch against 2.5.5-pre1, for us to
review and comment on? 

I believe there are probably still some issues to resolve, but I would
love to see a better makefile system for 2.5.

Regards,

	Jeff


-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
