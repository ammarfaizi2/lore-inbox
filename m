Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284983AbRLQDad>; Sun, 16 Dec 2001 22:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284985AbRLQDaY>; Sun, 16 Dec 2001 22:30:24 -0500
Received: from ns.suse.de ([213.95.15.193]:57097 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284983AbRLQDaK>;
	Sun, 16 Dec 2001 22:30:10 -0500
Date: Mon, 17 Dec 2001 04:30:09 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Momchil Velikov <velco@fadata.bg>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Copying to loop device hangs up everything
In-Reply-To: <87snab85tk.fsf@fadata.bg>
Message-ID: <Pine.LNX.4.33.0112170428460.11563-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Dec 2001, Momchil Velikov wrote:

> >> Can you repeat it with this applied ?
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17rc1aa1/00_loop-deadlock-1
> I've had exactly the same hangups with or without the patch.

You could be hitting a different bug.. highmem box ?

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

