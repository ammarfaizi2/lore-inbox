Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317805AbSGKJyA>; Thu, 11 Jul 2002 05:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317806AbSGKJx7>; Thu, 11 Jul 2002 05:53:59 -0400
Received: from dsl-213-023-038-138.arcor-ip.net ([213.23.38.138]:3212 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317805AbSGKJx5>;
	Thu, 11 Jul 2002 05:53:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH][RFT](2) minimal rmap for 2.5 - akpm tested
Date: Thu, 11 Jul 2002 11:58:01 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>,
       Sebastian Droege <sebastian.droege@gmx.de>,
       linux-kernel@vger.kernel.org, akpm@zip.com.au, linux-mm@kvack.org
References: <Pine.LNX.4.44L.0207101741380.14432-100000@imladris.surriel.com> <E17SPS5-00028e-00@starship> <20020711064712.GE1059@suse.de>
In-Reply-To: <20020711064712.GE1059@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Sai1-0002T7-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 July 2002 08:47, Jens Axboe wrote:
> On Wed, Jul 10 2002, Daniel Phillips wrote:
> > ...I'd be testing right
> > now to see if you're right, if the DAC960 driver compiled successfully.
> > But it doesn't, and since my test machine won't boot without it... given a
> > choice between diving into the driver and going back to work on directory
> > hashing on 2.4...
> 
> Leonard has promised me to convert DAC960 to the "new" pci dma api for
> years (or so it seems, actual date may vary, no purchase necessary). I
> do have a Mylex controller here myself these days, so it's not
> completely impossible that I may do it on a rainy day.

Well, tell me what the new api is and I'll dive in there.  For the record,
what happened to the old one?  Backwards compatibility dropped recently?
Mea culpa for not knowing, but those dma api threads were just so bushy.

I wouldn't be surprised if some other little things have rotted as well.

-- 
Daniel
