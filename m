Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262275AbRETXsN>; Sun, 20 May 2001 19:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262273AbRETXsE>; Sun, 20 May 2001 19:48:04 -0400
Received: from chiara.elte.hu ([157.181.150.200]:16143 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S262270AbRETXsB>;
	Sun, 20 May 2001 19:48:01 -0400
Date: Mon, 21 May 2001 01:46:18 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Russell King <rmk@arm.linux.org.uk>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Matthew Wilcox <matthew@wil.cx>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <Pine.GSO.4.21.0105201512450.8940-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0105210135240.1569-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 20 May 2001, Alexander Viro wrote:

> Linus, as much as I'd like to agree with you, you are hopeless
> optimist. 90% of drivers contain code written by stupid gits.

90% of drivers contain code written by people who do driver development in
their spare time, with limited resources, most of the time serving as a
learning excercise. And they do this freely and for fun. Accusing them of
being 'stupid gits' is just micharacterising the situation. People do not
get born as VFS hackers, there is a very steep learning curve, and only a
few make it to to have knowledge like you. Much of the learning curve of
various people has traces in drivers/*, it's more like the history of
Linux then some coherent image of people's capabilities.

	Ingo

