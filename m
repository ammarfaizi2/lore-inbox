Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271851AbSISWQy>; Thu, 19 Sep 2002 18:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272191AbSISWQy>; Thu, 19 Sep 2002 18:16:54 -0400
Received: from dsl-213-023-020-102.arcor-ip.net ([213.23.20.102]:25495 "EHLO
	starship") by vger.kernel.org with ESMTP id <S271851AbSISWQx>;
	Thu, 19 Sep 2002 18:16:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Dave Olien <dmo@osdl.org>
Subject: Re: [2.5] DAC960
Date: Fri, 20 Sep 2002 00:21:53 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jens Axboe <axboe@suse.de>, Samium Gromoff <_deepfire@mail.ru>,
       linux-kernel@vger.kernel.org
References: <E17odbY-000BHv-00@f1.mail.ru> <E17s6nH-0000xq-00@starship> <20020919150958.A27837@acpi.pdx.osdl.net>
In-Reply-To: <20020919150958.A27837@acpi.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17s9gL-00010c-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 September 2002 00:09, Dave Olien wrote:
> Daniel,
> 
> My mailer here has been misbehaving.  I didn't think THIS mail
> had actually made it out.  So, you may be seeing another version
> of this mail sometime.  Just ignore it.
> 
> I think some coding style repairs would be great!  But I'd like to
> hold off on that until we've finished all the functional changes.
> That way, anyone doing a code review can easily see only the
> changes to make the driver function.
> 
> Once functional changes are mostly complete, then cleaning up
> some coding style issues would be a good thing.

Yep.  And this is not a halloween deadline kind of thing, or more
accurately, you just did the halloween part of it.  The rest of the
job is to try to make it nice.  It would be great to find out if the
hardware is really as slow as it seems, or if it's the driver.

> Regarding being a mainteiner, lets get the code changes done
> first ;-)

It's working!  I see this in very simple terms ;-)

-- 
Daniel
