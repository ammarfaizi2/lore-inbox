Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130131AbRB1JL4>; Wed, 28 Feb 2001 04:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130139AbRB1JLr>; Wed, 28 Feb 2001 04:11:47 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:48646 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S130129AbRB1JLe>; Wed, 28 Feb 2001 04:11:34 -0500
Date: Wed, 28 Feb 2001 04:25:25 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <Pine.LNX.4.33.0102280908480.1266-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0102280425030.7369-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Feb 2001, Mike Galbraith wrote:

> > > Have you tried to use SWAP_SHIFT as 4 instead of 5 on a stock 2.4.2-ac5 to
> > > see if the system still swaps out too much?
> >
> > Not yet, but will do.

But what about swapping behaviour? 

It still swaps too much? 

