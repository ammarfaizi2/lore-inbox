Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131539AbQKPXvI>; Thu, 16 Nov 2000 18:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131606AbQKPXus>; Thu, 16 Nov 2000 18:50:48 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:47876
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S131539AbQKPXun>; Thu, 16 Nov 2000 18:50:43 -0500
Date: Fri, 17 Nov 2000 12:20:38 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Denison <peterd@pnd-pc.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Which compiler to use?
Message-ID: <20001117122038.A15379@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.21.0011162255460.1527-100000@pnd-pc.demon.co.uk> <E13wY9Z-0008WR-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13wY9Z-0008WR-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Nov 16, 2000 at 11:09:11PM +0000
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2000 at 11:09:11PM +0000, Alan Cox wrote:

    2.95.2 miscompiles strstr in some cases too. Current 2.2 however has strstr
    no longer inlined. I got bored of playing guess the compiler bug

What about 2.95.2 + 400K_of_patches that many vendors ship with? I
ended up patch hunting for 2.95.2 a few months back when I discovered
it was miscompiling c++ code and ended up with something that seems
to work... is there a definitive way to tell?


  --cw


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
