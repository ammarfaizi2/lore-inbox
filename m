Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129688AbQKQL7D>; Fri, 17 Nov 2000 06:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129720AbQKQL6x>; Fri, 17 Nov 2000 06:58:53 -0500
Received: from p3EE3CBE2.dip.t-dialin.net ([62.227.203.226]:55045 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129688AbQKQL6o>; Fri, 17 Nov 2000 06:58:44 -0500
Date: Fri, 17 Nov 2000 12:28:42 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Which compiler to use?
Message-ID: <20001117122842.A24565@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011162255460.1527-100000@pnd-pc.demon.co.uk> <E13wY9Z-0008WR-00@the-village.bc.nu> <20001117122038.A15379@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001117122038.A15379@metastasis.f00f.org>; from cw@f00f.org on Fri, Nov 17, 2000 at 12:20:38 +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Chris Wedgwood wrote:

> On Thu, Nov 16, 2000 at 11:09:11PM +0000, Alan Cox wrote:
> 
>     2.95.2 miscompiles strstr in some cases too. Current 2.2 however has strstr
>     no longer inlined. I got bored of playing guess the compiler bug
> 
> What about 2.95.2 + 400K_of_patches that many vendors ship with? I
> ended up patch hunting for 2.95.2 a few months back when I discovered
> it was miscompiling c++ code and ended up with something that seems
> to work... is there a definitive way to tell?

It'd then be better if there would be bug-fix releases of 2.95, I
imagine they'd be called 2.95.2.1 or 2.95.3.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
