Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268086AbRG3Vhr>; Mon, 30 Jul 2001 17:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268304AbRG3Vhh>; Mon, 30 Jul 2001 17:37:37 -0400
Received: from hilbert.umkc.edu ([134.193.4.60]:27667 "HELO tesla.umkc.edu")
	by vger.kernel.org with SMTP id <S268086AbRG3VhX>;
	Mon, 30 Jul 2001 17:37:23 -0400
Message-ID: <3B65D190.BBF4C79A@kasey.umkc.edu>
Date: Mon, 30 Jul 2001 16:28:48 -0500
From: "David L. Nicol" <david@kasey.umkc.edu>
Organization: UMKC Information Services Central Systems
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: When will ETCP be in linux kernels? Is there a patch?
In-Reply-To: <Pine.LNX.4.10.10107300127170.13088-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Mark Hahn wrote:
> 
> > > > Will ETCP
> > > > http://www.chem.ucla.edu/~beichuan/etcp/
> > > > be appearing in linux kernels any time soon?  We have ECN...
> > >
> > > isn't it just a draft?  I though ECN was considerably further along...
> >
> > No, it works -- if you set up a BSD system and apply their patch,
> > the second image loads fully too -- I did it once, and it worked
> > just like it is supposed to.
> 
> that wasn't the question: is it just a draft, or a standard like ECN?
> whether there's working code is orthogonal to it's standardization...

A working implementation (blessed by Christian Huitama) is IMO a defacto
standard.

I inquired of the TCP-IMPL working group about setting something like
ETCP up, to the point of submitting an independent proposal pretty much
describing it, and was referred to the ETCP demonstration.



-- 
                                           David Nicol 816.235.1187
    Cell phones are pretty much what Marconi had in mind, you know?

