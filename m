Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbSJUOfs>; Mon, 21 Oct 2002 10:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261460AbSJUOfr>; Mon, 21 Oct 2002 10:35:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11907 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261403AbSJUOfq>; Mon, 21 Oct 2002 10:35:46 -0400
Date: Mon, 21 Oct 2002 10:43:49 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Amol Kumar Lad <amolk@ishoni.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: gzip compression of vmlinux
In-Reply-To: <1035243705.2202.3.camel@amol.in.ishoni.com>
Message-ID: <Pine.LNX.3.95.1021021102607.10547A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Oct 2002, Amol Kumar Lad wrote:

> Hi,
>  Currently we use gzip to compress vmlinux ( and finally form bzImage).
> I am planning to replace it with bzip2 . Should I go ahead with it ?
> Will it find its place in the latest kernel ? 
> We save some 35k of compressed bzImage using bzip2
> 
> Please cc me
> 
> Thanks
> Amol

Is it allowed? I think Phil Katz had some claim to this since
he created the compression method by combining several published
algorithms. Don't hit me with fire, I was involved in the PK/ARC
Lawsuit. I am distinctly aware of his work.

The RedHat bzip2 Web Page seems to say that it's all "Free Software".
I suppose, upon the death of an author, everything's up for grabs.

At the very least, if you use this method, I suggest you name the
output file pkImage.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

