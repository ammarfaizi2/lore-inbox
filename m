Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265764AbRF2IUK>; Fri, 29 Jun 2001 04:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265769AbRF2IUA>; Fri, 29 Jun 2001 04:20:00 -0400
Received: from adsl-63-198-73-118.dsl.lsan03.pacbell.net ([63.198.73.118]:18182
	"HELO turing.xman.org") by vger.kernel.org with SMTP
	id <S265764AbRF2ITt>; Fri, 29 Jun 2001 04:19:49 -0400
Message-Id: <5.1.0.14.0.20010629011855.00a98098@imap.xman.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 29 Jun 2001 01:19:50 -0700
To: "Daniel R. Kegel" <dank@alumni.caltech.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Christopher Smith <x@xman.org>
Subject: Re: A signal fairy tale
In-Reply-To: <200106280257.TAA06889@alumnus.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:57 PM 6/27/2001 -0700, Daniel R. Kegel wrote:
>From: Christopher Smith <x@xman.org>
> >I guess the main thing I'm thinking is this could require some significant
> >changes to the way the kernel behaves. Still, it's worth taking a "try it
> >and see approach". If anyone else thinks this is a good idea I may hack
> >together a sample patch and give it a whirl.
>
>What's the biggest change you see?  From my (two-martini-lunch-tainted)
>viewpoint, it's just another kind of signal masking, sorta...

Yeah, the more I think about it, the more I think this is just another 
branch in the signal delivery code. Not necessarily too huge a change. I'll 
hack on this over the weekend I think.

--Chris

