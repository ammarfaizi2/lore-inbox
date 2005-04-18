Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVDRLJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVDRLJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 07:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVDRLJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 07:09:48 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:43203 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262033AbVDRLJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 07:09:28 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: Need some help to debug a freeze on 2.6.11
From: Alexander Nyberg <alexn@dsv.su.se>
To: Ehud Shabtai <eshabtai.lkml@gmail.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org
In-Reply-To: <68b6a2bc05041803561621ddd6@mail.gmail.com>
References: <68b6a2bc050418000619a552de@mail.gmail.com>
	 <1113818666.357.17.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0504181215590.2522@dragon.hyggekrogen.localhost>
	 <Pine.LNX.4.62.0504181220090.2522@dragon.hyggekrogen.localhost>
	 <68b6a2bc05041803561621ddd6@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 13:09:27 +0200
Message-Id: <1113822567.365.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Sounds like a job for Documentation/networking/netconsole.txt
> > > >
> > > or Documentation/serial-console.txt
> > >
> > Console on line printer would also be an option.
> 
> I don't have any printer port cables, so I guess I prefer to try netconsole.
> 
> I'm using wireless lan (Intel's ipw2100), would netconsole work on
> wlan interface?

Not sure, can't comment on it...

> As an alternative, can I configure netconsole for my ethernet port and
> only really connect it, after I get the freeze?

Yep, this will work well.

