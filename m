Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130589AbQK0N3u>; Mon, 27 Nov 2000 08:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130897AbQK0N3l>; Mon, 27 Nov 2000 08:29:41 -0500
Received: from univ.uniyar.ac.ru ([193.233.51.120]:39625 "EHLO
        univ.uniyar.ac.ru") by vger.kernel.org with ESMTP
        id <S130589AbQK0N3c>; Mon, 27 Nov 2000 08:29:32 -0500
Date: Mon, 27 Nov 2000 15:59:05 +0300 (MSK)
From: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, andy@lysaker.kvaerner.no
Subject: Re: Kernel Oops on locking sockets via fcntl()
In-Reply-To: <20001124145540.A13064@gruyere.muc.suse.de>
Message-ID: <Pine.GSO.3.96.SK.1001127155810.24276A-100000@univ.uniyar.ac.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000, Andi Kleen wrote:

> On Fri, Nov 24, 2000 at 04:32:26PM +0300, Igor Yu. Zhbanov wrote:
> > Hello!
> > 
> > One fine day accidentally I have opened an Xserver's socket placed in /tmp
> > with my favourite text editor "le". I have got a message from the kernel similar
> > to this:
> 
> 
> Which kernel version are you using ? It should be already fixed in all 
> modern kernels (newer 2.2 and 2.4) 
> 
> 
> -Andi
> 

My Kernel version is 2.2.17

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
