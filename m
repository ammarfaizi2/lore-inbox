Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422641AbVLOJfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbVLOJfb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422667AbVLOJfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:35:31 -0500
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:16970 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1422641AbVLOJfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:35:30 -0500
Message-ID: <BAYC1-PASMTP038CB4D1F79AE7F36E031EAE3B0@CEZ.ICE>
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Message-ID: <48526.10.10.10.28.1134639327.squirrel@linux1>
In-Reply-To: <200512151131.39216.a1426z@gawab.com>
References: <200512150013.29549.a1426z@gawab.com>
    <200512150749.29064.a1426z@gawab.com> <43A0FE13.8010303@yahoo.com.au>
    <200512151131.39216.a1426z@gawab.com>
Date: Thu, 15 Dec 2005 04:35:27 -0500 (EST)
Subject: Re: Linux in a binary world... a doomsday scenario
From: "Sean" <seanlkml@sympatico.ca>
To: "Al Boldi" <a1426z@gawab.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>, "Greg KH" <greg@kroah.com>,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 15 Dec 2005 09:35:29.0694 (UTC) FILETIME=[E330ABE0:01C6015A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 11:31 +0300, Al Boldi wrote:

> The fact that somebody may take advantage of a stable API should not lead
>  us to reject the idea per se.

True.  But then nobody said the idea was rejected for that reason, just
that supporting binary drivers is not a compelling reason to embrace a
stable API.  In other words, supporting binary drivers is not nearly as
important as other factors which would be harmed by a stable API.

> The objective of a stable API would be to aid the collective effort and
> not to divide it.

The collective effort seems to be doing just fine without it.

> If you are working alone a stable API would be overkill.  But GNU/Linux
> is a collective effort, where stability is paramount to aid scalability.
>
> I hope the concepts here are clear.

No, it's not clear what you mean by scalability.  What is it exactly that
you think would be more scalable?   As has been mentioned already, there
is no better example today of scalable development than the Linux kernel. 
So, I don't think you've laid out at all what it is you're talking about.

> No troll! Just being IMHO. I hope that's OK?
>
> Of course, if your aim is not to be scalable then please ignore this
> message as it will not have any meaning.

The linux kernel development model scales very well.  Linux itself scales
from the smallest embedded processors to the largest parallel computing
farms today; all without a stable internal API.  So you've failed to make
a case that there is a problem for which a stable API is the solution.

Cheers,
Sean

