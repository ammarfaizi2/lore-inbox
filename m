Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262259AbRENQYt>; Mon, 14 May 2001 12:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262265AbRENQYj>; Mon, 14 May 2001 12:24:39 -0400
Received: from dyn7d0.dhcp.lancs.ac.uk ([148.88.247.208]:516 "EHLO
	dyn7d0.dhcp.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S262259AbRENQYg>; Mon, 14 May 2001 12:24:36 -0400
Date: Sat, 12 May 2001 12:46:40 +0100 (BST)
From: Stephen Torri <s.torri@lancaster.ac.uk>
X-X-Sender: <torri@dyn7d0.dhcp.lancs.ac.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOPS on 2.4.4-ac4
In-Reply-To: <E14yNPC-0001te-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0105121244020.3535-100000@dyn7d0.dhcp.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The nvidia driver has been fine for me up to 2.4.2-ac20. I am going to
update to 2.4.4-ac8 today. In regards to the module the source code is
available from nvidia for inspection. The library that they want you to
use with it is binary only. The library should be source code as well but
the powers that be have said otherwise.

I will keep tabs on the release for kernel oops as well. I am using XFree
4.0.3 with NVIDIA-0.9-769

Stephen

On Sat, 12 May 2001, Alan Cox wrote:

> > > Ok, I will remove vmware and switch from the nvidia driver the nv
> driver from > XFree 4.3. Maybe I get the oops again.
>
> Let me know if you do. I've got some other dmfe reports I'm looking at so its
> quite possible that is the trigger, but this time I'll be able to know its not
> giant binary stuff 8)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
-----------------------------------------------
Buyer's Guide for a Operating System:
Don't care to know: Mac
Don't mind knowing but not too much: Windows
Hit me! I can take it!: Linux


