Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUHJRCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUHJRCu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 13:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267562AbUHJQuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:50:54 -0400
Received: from ppp2-adsl-200.the.forthnet.gr ([193.92.233.200]:10028 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S267567AbUHJQuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:50:17 -0400
From: V13 <v13@priest.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH 2.6] Remove spaces from PCI IDE pci_driver.name field
Date: Tue, 10 Aug 2004 19:52:17 +0300
User-Agent: KMail/1.7
Cc: Tomas Szepe <szepe@pinerecords.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       dsaxena@plexity.net, greg@kroah.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040810001316.GA7292@plexity.net> <20040810155701.GB21534@louise.pinerecords.com> <1092154407.10794.14.camel@mindpipe>
In-Reply-To: <1092154407.10794.14.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408101952.18710.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 August 2004 19:13, Lee Revell wrote:
> On Tue, 2004-08-10 at 11:57, Tomas Szepe wrote:
> > Sure, but while with a GUI you can click on almost anything, on the
> > command line spaces in filenames have always been a real pain in
> > the ass, so let's not pretend otherwise.
>
> Ever heard of tab completion?  Think of it as click for the command
> line.
>
> Seriously, do you really *prefer* filenames like
> Foo_Bar-Baa_Baaz_Quux.mp3?

Anyone that writes scripts prefers filenames without spaces. It simplifies 
scripts *and* typing a lot. 

Card\ 01
Card\ 02
Cardinal

Now we have to write: cd Ca<tab>\ <tab>1<tab/space>

On the other hand, perhaps /sys should be named 'My computer' :P

> Lee
<<V13>>

p.s. I believe upper-lower case is a similar (or worst) 'problem' too, 
regarding typing.
