Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267541AbTAMQbj>; Mon, 13 Jan 2003 11:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267647AbTAMQbj>; Mon, 13 Jan 2003 11:31:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18188 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267541AbTAMQbi>; Mon, 13 Jan 2003 11:31:38 -0500
Date: Mon, 13 Jan 2003 08:35:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <20030113062300.GA3804@kroah.com>
Message-ID: <Pine.LNX.4.44.0301130834500.1903-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Jan 2003, Greg KH wrote:
> 
> Anyway, here's a patch with your new lock, if you want to apply it.

I'd like to have some verification (or some test-suite) to see whether it 
makes any difference at all before applying it.

Alan, what's your load?

		Linus

