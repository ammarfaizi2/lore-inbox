Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131955AbRAXA1Q>; Tue, 23 Jan 2001 19:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132006AbRAXA1G>; Tue, 23 Jan 2001 19:27:06 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:31495
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131955AbRAXA1D>; Tue, 23 Jan 2001 19:27:03 -0500
Date: Tue, 23 Jan 2001 16:26:40 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Florin Andrei <florin@sgi.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 disk speed 66% slowdown...
In-Reply-To: <3A6E1EB7.62B6256D@sgi.com>
Message-ID: <Pine.LNX.4.10.10101231625290.11205-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001, Florin Andrei wrote:

> Linda Walsh wrote:
> > 
> > The REAL problem was in disk performance.  The apm made no difference:
> 
> 	Same problem here. I had a huge HDD performance drop when upgrading
> from 2.2.18 to 2.4.0
> 	It's an Intel i815 motherboard, and the HDD is Ultra-ATA.

ER, were you getting UDMA-100-66 out of 2.2.18 stock?
Now what are you getting in 2.4.0?

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
