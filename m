Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310540AbSC2RTP>; Fri, 29 Mar 2002 12:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310549AbSC2RTH>; Fri, 29 Mar 2002 12:19:07 -0500
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:41089 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S310540AbSC2RSy>;
	Fri, 29 Mar 2002 12:18:54 -0500
Date: Fri, 29 Mar 2002 17:16:23 GMT
Message-Id: <200203291716.g2THGNq08251@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: davidm@hpl.hp.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic show_stack facility
In-Reply-To: <15524.40817.306204.292158@napali.hpl.hp.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <15524.40817.306204.292158@napali.hpl.hp.com> you wrote:
>>>>>> On Fri, 29 Mar 2002 16:06:18 +0000, Christoph Hellwig <hch@infradead.org> said:
> 
>  Christoph> On Fri, Mar 29, 2002 at 07:46:07AM -0800, David Mosberger
>  Christoph> wrote:
>  >> Christoph, why do you think the prototype for ia64 is different?
> 
>  Christoph> I have stopped to wonder why ia64 does things
>  Christoph> differently.
> 
> You might want to reconsider that stance.  It could open your mind. ;-)
> 
> BTW: this is not at all an ia64-specific issue.  It applies to any
> arch that doesn't maintain a frame pointer on the stack.  Basic
> compiler technology.

oh you mean like x86 ?
