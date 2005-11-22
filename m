Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVKVBCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVKVBCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbVKVBCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:02:19 -0500
Received: from [81.2.110.250] ([81.2.110.250]:4527 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750763AbVKVBCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:02:19 -0500
Subject: Re: [RFC] Small PCI core patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
	 <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Nov 2005 01:34:27 +0000
Message-Id: <1132623268.20233.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-22 at 11:47 +1100, Dave Airlie wrote:
> And funny enough unlike SCSI adapters and things for large server
> installations, nobody seems to really care enough about graphics
> cards, I've heard horror stories about how little Linux companies

Its easy to see why

The graphics market between Nvidia and ATI is extreme rivalry
There have been some ugly patent lawsuits
Good software tricks can make the weaker hardware win
Its very hard to write

So there are real secrets left in the market. Designing a SCSI
controller isn't exactly a McJob but its commodity.


Nvidia are at least trying to do what they can within what for them is
not a very easy set of market conditions for open sourcing. ATI were
doing very nice things until they won the Xbox 360 contract. An
observation that perhaps would not go amiss reaching the US legal
watchdogs.

Alan
