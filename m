Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262406AbRFKRAE>; Mon, 11 Jun 2001 13:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262421AbRFKQ7y>; Mon, 11 Jun 2001 12:59:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2067 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262406AbRFKQ7t>; Mon, 11 Jun 2001 12:59:49 -0400
Subject: Re: [CHECKER] 15 probable security holes in 2.4.5-ac8
To: jcwren@jcwren.com
Date: Mon, 11 Jun 2001 17:58:05 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <NDBBKBJHGFJMEMHPOPEGEEDBCJAA.jcwren@jcwren.com> from "John Chris Wren" at Jun 11, 2001 12:54:51 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E159V0v-0008UM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ideally, yes.  However, client side DSP at these kinds of data rates still
> isn't practical.  Most people are lucky if they can get 9600 baud, although
> admittedly some of that is a function of trying to use a standard sound card
> with it's limited input bandwidth (apx 22Khz).

A P200 can do the DSP work required to do 9600 baud with full FEC. I doubt
you'll find USB on anything slower

> I don't know if you're familiar with the Heatherington 56K design or not,

Not really. The last interesting thing I looked at was shifting arcnet into
the 10GHz band for 1Mbit point to point links

> but there's some information at his website, www.wa4dsy.org.  Dale, for

I recognize the call tho -  NOS supported some of his stuff

