Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVF0KMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVF0KMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 06:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVF0KMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 06:12:15 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:55241 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261431AbVF0KMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 06:12:06 -0400
Subject: Re: Promise ATA/133 Errors With 2.6.10+
From: Erik Slagter <erik@slagter.name>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1119808784.28649.41.camel@localhost.localdomain>
References: <Pine.LNX.4.63.0506241653580.31140@p34>
	 <1119688191.4293.5.camel@localhost.localdomain>
	 <Pine.LNX.4.63.0506250435110.32759@p34>
	 <1119808784.28649.41.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Jun 2005 12:11:36 +0200
Message-Id: <1119867096.4020.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-26 at 18:59 +0100, Alan Cox wrote:
> On Sad, 2005-06-25 at 09:35, Justin Piszcz wrote:
> > > BTW2 could it be that somewhere a timeout has been lowered in recent
> > > kernels? That must have been pre-2.6.11 then.
> 
> Timeouts have not changed or have increased in fact.

Never mind, the offending harddisk has ceased to be yesterday, it is no
more.

What really bothers me, though, is that until the very last moment it
was alive, it didn't report any smart error, nor did any self test fail.
I guess IBM is to blame here :-(
