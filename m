Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265871AbRFYDxN>; Sun, 24 Jun 2001 23:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbRFYDxD>; Sun, 24 Jun 2001 23:53:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22857 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S265871AbRFYDwy>; Sun, 24 Jun 2001 23:52:54 -0400
To: David Lang <david.lang@digitalinsight.com>
Cc: John Nilsson <pzycrow@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Some experience of linux on a Laptop
In-Reply-To: <Pine.LNX.4.33.0106241325240.7535-100000@dlang.diginsite.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Jun 2001 21:48:20 -0600
In-Reply-To: <Pine.LNX.4.33.0106241325240.7535-100000@dlang.diginsite.com>
Message-ID: <m17ky1b4or.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <david.lang@digitalinsight.com> writes:

> On Sun, 24 Jun 2001, John Nilsson wrote:
> > 8: A way to change kernel without rebooting. I have no diskdrive or cddrive
> > in my laptop so I often do drastic things when I install a new distribution.
> 
> this is suggested every few months, the normal answer is that there is a
> lot of stuff that the new kernel needs to know from the old one to make
> the handoff sucessful, with potentially drastic changes of the kernel
> internal structures it's a very difficult thing to do.

What do you want this for?  If you don't need to preserve user space
I have code that already does this.  If you need to preserver the user
space it is a trickier problem.  But I have heard rumors of a suspend
to swap patch...

Eric

