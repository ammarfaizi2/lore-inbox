Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKXO0K>; Fri, 24 Nov 2000 09:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129153AbQKXO0A>; Fri, 24 Nov 2000 09:26:00 -0500
Received: from Cantor.suse.de ([194.112.123.193]:20232 "HELO Cantor.suse.de")
        by vger.kernel.org with SMTP id <S129091AbQKXOZq>;
        Fri, 24 Nov 2000 09:25:46 -0500
Date: Fri, 24 Nov 2000 14:55:40 +0100
From: Andi Kleen <ak@suse.de>
To: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
Cc: linux-kernel@vger.kernel.org, andy@lysaker.kvaerner.no
Subject: Re: Kernel Oops on locking sockets via fcntl()
Message-ID: <20001124145540.A13064@gruyere.muc.suse.de>
In-Reply-To: <Pine.GSO.3.96.SK.1001124163030.25896C-100000@univ.uniyar.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.SK.1001124163030.25896C-100000@univ.uniyar.ac.ru>; from bsg@uniyar.ac.ru on Fri, Nov 24, 2000 at 04:32:26PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2000 at 04:32:26PM +0300, Igor Yu. Zhbanov wrote:
> Hello!
> 
> One fine day accidentally I have opened an Xserver's socket placed in /tmp
> with my favourite text editor "le". I have got a message from the kernel similar
> to this:


Which kernel version are you using ? It should be already fixed in all 
modern kernels (newer 2.2 and 2.4) 


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
