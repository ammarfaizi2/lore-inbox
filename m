Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319028AbSHSVcK>; Mon, 19 Aug 2002 17:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319029AbSHSVcK>; Mon, 19 Aug 2002 17:32:10 -0400
Received: from dsl-213-023-021-229.arcor-ip.net ([213.23.21.229]:19077 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319028AbSHSVcJ>;
	Mon, 19 Aug 2002 17:32:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Mel <mel@csn.ul.ie>
Subject: Re: [PATCH] rmap 14
Date: Mon, 19 Aug 2002 23:38:21 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
References: <Pine.LNX.4.44.0208192204260.23261-100000@skynet>
In-Reply-To: <Pine.LNX.4.44.0208192204260.23261-100000@skynet>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17guEA-0000vQ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 August 2002 23:19, Mel wrote:
> On Mon, 19 Aug 2002, Daniel Phillips wrote:
> 
> > It sounds like you want to try the linux trace toolkit:
> >
> >    http://www.opersys.com/LTT/
> >
> 
> I have been looking it's direction a couple of times. I suspect I'll
> eventually end up using it to answer some questions

That's exactly what I meant - when you uncover something interesting with
your test tool, you investigate it further with LTT.

> but I'm trying to
> get as far as possible without using large kernel patches. At the moment
> the extent of the patches involves exporting symbols to modules

I think you've chosen roughly the right level to approach this.

-- 
Daniel
