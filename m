Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129663AbQL2CQz>; Thu, 28 Dec 2000 21:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130231AbQL2CQp>; Thu, 28 Dec 2000 21:16:45 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:29959
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129663AbQL2CQh>; Thu, 28 Dec 2000 21:16:37 -0500
Date: Fri, 29 Dec 2000 14:46:09 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, chris@freedom2surf.net,
        linux-kernel@vger.kernel.org
Subject: Re: Repeatable Oops in 2.4t13p4ac2
Message-ID: <20001229144609.B16930@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.21.0012281305530.12295-100000@freak.distro.conectiva> <E14BghF-0003wu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14BghF-0003wu-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 28, 2000 at 05:18:30PM +0000
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 05:18:30PM +0000, Alan Cox wrote:

    For -ac Im working on the assumption I introduced a bug into the
    mm code

after discussion with you and further pounding with t13p4+cw (not ac)
I am fairly confident something in ac2 is fishy. I can repeatable get
ac2 to fail with PCMCIA and also reiserfs under load, I absolutely
cannot get these failures without ac2.

This is totally repeatable so if you want further diagnostics please
let me know....



  --cw

P.S. Using 2.95.2 if that matters; it's more or less always works but
     maybe ac2 triggers something there as some people seem to find
     ac2 pretty good?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
