Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWGVTTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWGVTTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 15:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWGVTTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 15:19:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:53096 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750992AbWGVTTP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 15:19:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=JngCBw7u2vGDFEbH6oKJSsaR4I2olAzLXR1YczVUk2uMZXm/I5KVe9I54ejOWh5bx5lnZt54y+CUOHA5hatxhtQfJWhHcRL1inxiOb2wW0hOi61XcGOMV3RJhOWdLyWCOoI8kzR1KCR2M0BBcHufykHYte8fTeph3Bq0nOlE788=
Date: Sat, 22 Jul 2006 21:19:06 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
Message-Id: <20060722211906.8e120d54.diegocg@gmail.com>
In-Reply-To: <20060722001819.GP25367@stusta.de>
References: <44C12F0A.1010008@namesys.com>
	<20060722001819.GP25367@stusta.de>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 22 Jul 2006 02:18:19 +0200,
Adrian Bunk <bunk@stusta.de> escribió:

> After two users asked the "Why is Reiser4 still not included?" question 
> within a very short amount of time on this list (mailing lists aren't 
> write-only, and this issue has been discussed often before...), Diego 
> wrote an FAQ for this issue.
> 
> Emails by people like Linus, Andrew, Christoph or Al are what comes 
> nearest to an official statement.

[I'm the guy who wrote the doc]

I didn't write "It could possibly be ready as soon as 2.6.19" literally,
that was someone that reworked my (ugly) english. Being fair what make
me wrote that pages was the huge amount of people FUDing about linux
developers in online forums (including this list)

> > You can't really have code reviewed by persons less experienced and
> > proven than those being reviewed, it just doesn't work too well.  Linux

Hans, stop that "we're smarter than you" attitude. It's not surprising
that reiser 4 creates so many flames and that it's getting so hard to make
progress, with such strong arguments. As far as I can tell, most of the
kernel hackers trust Al Viro and hch on their opinions, specially in
fs-related issues - and for good reasons. They know linux and they 
know how a linux fs must behave. As long as a fs plays well with the
rest of the system and the code doesn't suck, I doubt they care too
much if it's very advanced or arcane, and the huge variety of
filesystem available in linux confirms that.

> > as they need them.  Our current attitude resembles that of BSD before it
> > lost the market to Linux, I remember it well, there was a reason why I
> > developed for Linux instead.

Hans, I don't agree. If anything, the problem is that right now there's
not a "development" stage: people just takes more care about what goes
in, it wouldn't happen the same under a development stage. That certainly
could make the job of big projects like reiser 4 much harder.
