Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130572AbRBSOxF>; Mon, 19 Feb 2001 09:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130612AbRBSOwz>; Mon, 19 Feb 2001 09:52:55 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:38208 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130572AbRBSOwp>; Mon, 19 Feb 2001 09:52:45 -0500
Date: Mon, 19 Feb 2001 08:52:15 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Manfred Bartz <md-linux-kernel@logi.cc>
cc: linux-kernel@vger.kernel.org
Subject: Re: ethernet driver probs (tulip, de4x5, 3c509)
In-Reply-To: <20010219130742.1798.qmail@logi.cc>
Message-ID: <Pine.LNX.3.96.1010219085051.17842D-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Feb 2001, Manfred Bartz wrote:
> I have 3 NICs (2*DEC, 1*3c509) in my gateway (P75, 40M RAM).
> 
> tulip.o in 2.4.1 insists on selecting 10baseT, no command
> line option can convince it otherwise.  tulip.o in 2.2.16 auto
> detected media and worked fine.

A little info on your cards would be helpful.  With well over 100
different types of Tulip cards, I can't just read your mind :)

lspci, tulip-diag, and dmesg output would all be helpful.


> de4x5.o in 2.4.1 needs to be told the media, then works fine.
> de4x5.o in 2.2.16 auto detected media and worked fine.

de4x5 is going away, anyway.

	Jeff




