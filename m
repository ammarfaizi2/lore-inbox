Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265560AbUEZMrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265560AbUEZMrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265569AbUEZMrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:47:08 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:19725 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265560AbUEZMqd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:46:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Buddy Lumpkin" <b.lumpkin@comcast.net>,
       "'William Lee Irwin III'" <wli@holomorphy.com>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 15:40:50 +0300
X-Mailer: KMail [version 1.4]
Cc: <orders@nodivisions.com>, <linux-kernel@vger.kernel.org>
References: <S265489AbUEZLfK/20040526113510Z+1673@vger.kernel.org>
In-Reply-To: <S265489AbUEZLfK/20040526113510Z+1673@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200405261540.50539.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 May 2004 10:55, William Lee Irwin III wrote:
> On Wed, May 26, 2004 at 12:31:16AM -0700, Buddy Lumpkin wrote:
> > This of course doesn't address the VM paging storms that happen due to
> > large amounts of file system writes. Once the pagecache fills up, dirty
> > pages must be evicted from the pagecache so that new pages can be added
> > to the pagecache.
>
> If you've got a real performance issue, please describe it properly
> instead of asserting without evidence the existence of one.

On Wed, May 26, 2004 at 01:30:09AM -0700, Buddy Lumpkin wrote:
> As for your short, two sentence comment below, let me save you the energy of
> insinuations and translate your message the way I read it: 
> -------------------------------------------------------------------------
> I don't recognize your name, therefore you can't possibly have a valuable
> opinion on the direction VM system development should go. I doubt you have
> an actual performance problem to share, but if you do, please share it and
> go away so that we can work on solving the problem.
> --------------------------------------------------------------------------
> My response:
> Get over yourself.

You were very wrong here. He did not say that. You pervert his words.

On Wednesday 26 May 2004 12:09, William Lee Irwin III wrote:
> >- My response:
> > Get over yourself.
>
> What the Hell? I have enough bugs I'm paid to fix that I'm not going to
> tolerate harassment for requesting that claims that the kernel behaves
> pathologically in some scenario be cast as comprehensible bugreports.
> It's also worth noting that paying customers don't respond so uncouthly.

wli, understandably, become angry.

On Wednesday 26 May 2004 14:38, Buddy Lumpkin wrote:
> If you follow the thread, you will see no claim from me that there is
> anything wrong with the kernel. I simply stated that the priority of VM
> system development should focus on physical memory...
...
> This situation isn't even remotely similar. In this case, you (a
> contributor to a very, very large FREE software project) misread a thread
> and made some surly comments that you ended up eating, and are so used to
> telling people that you owe them nothing, that you have some how conjured
> up the image that I actually want something from you.
...
> This is classic, you have managed to put yourself in a position where you
> spend the majority of your time working on a free project that has some
> very ambitious goals. It has afforded you the ability to forfill your own
> personal and professional goals as well, yet you reserve the right to
> discard all accountability for your actions when it's convenient because
> you get some frank feedback from someone that is not a paying customer.
>
> What a crutch.
>
> I can picture where this is going. Here is an interview between you and a
> popular Linux magazine in two years:

<joke>
Aha!
Now we all know that wli is evil. Thanks for your crystall ball.
</joke>
--
vda
