Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267527AbTALVNc>; Sun, 12 Jan 2003 16:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267528AbTALVNc>; Sun, 12 Jan 2003 16:13:32 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:5629 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267527AbTALVNa>; Sun, 12 Jan 2003 16:13:30 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1042404264.16288.28.camel@irongate.swansea.linux.org.uk> 
References: <1042404264.16288.28.camel@irongate.swansea.linux.org.uk>  <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <1042400219.1208.29.camel@RobsPC.RobertWilkens.com> <20030112195347.GJ3515@louise.pinerecords.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tomas Szepe <szepe@pinerecords.com>, Rob Wilkens <robw@optonline.net>,
       Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*? 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Sun, 12 Jan 2003 21:22:00 +0000
Message-ID: <1535.1042406520@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  In evolution its
> Tools->Create filter from message->Filter on sender
> Add action
> 	Move to folder  QUAINT
> and then just read it when drunk 

That's fine for this particular troll, but some of the more well-known
trolls here are so good at what they do that you sometimes have to read
their messages while sober -- the errors can be subtle and well-hidden. So
much so, sometimes, that I suspect it's done on purpose.

Besides, filtering in the MUA is blatantly the wrong place to do it. The 
MTA (or MDA) should be doing the filtering.¹

--
dwmw2
¹ Yes, I'm bored of the other off-topic flames :)

