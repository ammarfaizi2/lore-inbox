Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277511AbRJKC3p>; Wed, 10 Oct 2001 22:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277811AbRJKC3f>; Wed, 10 Oct 2001 22:29:35 -0400
Received: from femail31.sdc1.sfba.home.com ([24.254.60.21]:12970 "EHLO
	femail31.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S277511AbRJKC3X>; Wed, 10 Oct 2001 22:29:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Andreas Dilger <adilger@turbolabs.com>
Subject: Re: Tainted Modules Help Notices
Date: Wed, 10 Oct 2001 18:29:01 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15rQjC-0000m2-00@the-village.bc.nu> <m2itdnf6a9.fsf@anano.mitica> <20011010172832.P10443@turbolinux.com>
In-Reply-To: <20011010172832.P10443@turbolinux.com>
MIME-Version: 1.0
Message-Id: <01101018290109.11498@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 October 2001 19:28, Andreas Dilger wrote:

> Given that "subversion" will only mean editing the text output of ksymoops
> to not display the "tainted" flag, I don't see it to be a big barrier to
> entry.  If it is in the FAQ (or documented elsewhere) that "if ksymoops
> says 'tainted: 1' submit your bug reports only to the vendor" it will be
> a small matter to delete that line, and if this is NOT documented anywhere
> it will not reduce the number of bug submissions, which was the original
> goal.

If it gets them to read the FAQ, it's done it's job already!

What the flag REALLY means is "I didn't read the FAQ."  In order to know to 
change it, they have to know why it's there...

And it's not to reduce submissions, it's to let Kernel hackers discard them 
more quickly.  (No force on earth can stop clueless requests for tech 
support.  It's like trying to stop spam.  All you can do is filter it more 
effectively.)


Rob
