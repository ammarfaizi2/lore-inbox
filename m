Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316782AbSE0X2h>; Mon, 27 May 2002 19:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316783AbSE0X2g>; Mon, 27 May 2002 19:28:36 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:60803 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S316782AbSE0X2g>; Mon, 27 May 2002 19:28:36 -0400
Date: Tue, 28 May 2002 00:28:36 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Jes Sorensen <jes@wildopensource.com>, <linux-kernel@vger.kernel.org>
Subject: Re: VM oops in RH7.3 2.4.18-3
In-Reply-To: <20020527123912.A15560@redhat.com>
Message-ID: <Pine.LNX.4.44.0205280026160.13855-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-uvscan-result: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 27 Benjamin LaHaise wrote:

>On Mon, May 27, 2002 at 10:33:12AM -0400, Jes Sorensen wrote:
>> >>>>> "Matt" == Matt Bernstein <matt@theBachChoir.org.uk> writes:
>>
>> Matt> This is a dual Athlon, 1 gig registered ECC DDR RAM, will try
>> Matt> 2.4.18-4 but it doesn't look ext3-related (the only big local
>> Matt> filesystem is reiserfs over s/w raid0).
>>
>> Please send this to Red Hat before the kernel list. They are
>> responsible for maintaining their kernel.
>
>I'm sure Rik is interested in any feedback on the rmap patches that
>occur out in the wild...  even if they happen in vendor kernels.  With
>that said, we appreciate getting bugs like this filed in bugzilla.

Thanks--I'll see what I can do, though I really don't have much more to go
on than the oops. I think power supply / cooling are not to blame.. :-/

Matt

