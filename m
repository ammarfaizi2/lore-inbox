Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271149AbRIGFEe>; Fri, 7 Sep 2001 01:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271165AbRIGFEY>; Fri, 7 Sep 2001 01:04:24 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:47886 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271149AbRIGFEG>; Fri, 7 Sep 2001 01:04:06 -0400
Subject: Re: Trouble with update Preemptive patch for 2.4.9-ac9
From: Robert Love <rml@tech9.net>
To: Jordan Breeding <ledzep37@home.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3B985287.2385275B@home.com>
In-Reply-To: <3B985287.2385275B@home.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 07 Sep 2001 01:04:33 -0400
Message-Id: <999839075.865.7.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-09-07 at 00:52, Jordan Breeding wrote:
> I have compiled an SMP kernel using 2.4.9-ac9 and the updates preemptive
> patch.  I had used the preemptive patch before on a UP machine and
> noticed a significant improvement so I decided to try it on SMP.  It
> worked very well for the first section of boot up, everything was MUCH
> more responsive (ie. start up scripts, etc.), then when it got to the
> startup script for CUPS everything barfed.  I am including the raw oops,
> the ksymoops output, and the .config file.  Hope this helps solve any
> SMP issues for preemption.  It would be nice to be able to use it...I
> remember it helped make the UP kernel and system I used to use seem much
> more responsive to common tasks.  Thanks to anyone who can help fix
> this.

I will take a look at this, but note that currently the patch is
experimental with SMP enabled.

I am glad you found an improvement on UP.  Hopefully we can get it
working on SMP, too.  I have never personally used it on SMP, but I had
heard it worked.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

