Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264381AbRFIQUY>; Sat, 9 Jun 2001 12:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264376AbRFIQUO>; Sat, 9 Jun 2001 12:20:14 -0400
Received: from sr3.terra.com.br ([200.176.3.63]:50186 "EHLO sr3.terra.com.br")
	by vger.kernel.org with ESMTP id <S264375AbRFIQUG>;
	Sat, 9 Jun 2001 12:20:06 -0400
Message-ID: <3B224CFC.2ECB7CE0@zaz.com.br>
Date: Sat, 09 Jun 2001 13:21:16 -0300
From: Paulo Afonso Graner Fessel <pafessel@zaz.com.br>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: pt-BR, en
MIME-Version: 1.0
To: "Mathiasen, Torben" <Torben.Mathiasen@compaq.com>
CC: linux-kernel@vger.kernel.org, hollis@austin.rr.com
Subject: Re: Probable endianess problem in TLAN driver
In-Reply-To: <22F662CDC53ED411B65700805F31DE1C135A70@exccop-01.dmo.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mathiasen, Torben" wrote:
> 
> Paulo,
> 
> Thanks for the update/patch. Sorry I missed your first email, bu I've been
> way too busy with other stuff the last couple of months.

Thank Hollis. :-) As I've already said, I'm really no kernel hacker.
OTOH I've programmed a lot 5+ years ago, so I can understand some
things. I'm relieved also that you have replied, because seemed that you
had a disease or something - your contributions both to the list and
updates to the page stopped abruptly.

> There's a lot of endianess issues in the tlan driver, but none really
> bothered fixing them. No one really assumed the tlan adapters would be used
> on bigendian machines. Well, let me say, you're probaly the first ;-).

Actually, I decided on Netelligent Dual because of two things:

* I had the oportunity to get such a board by a reasonable price (US$
50.00); here in Brazil, it's rather difficult to get real multiport
adapters (what is available are hubs-on-a-board. Bleargh). The ones
available are Adaptec ones, and here they cost US$ 500.00 up. Too bad
because they have the 21x4x chip that works flawlessly on PPC. :-(

* I've read someplace that someone got to make TLAN work on PowerPC (no
links, please :-). He said also that MacOS would olympically ignore the
driver, but it would work on PPCLinux.

Even in US multiport Adaptec boards are not cheap; in eBay prices vary
from US$ 150 to US$ 225.
 
> Now, I have pile of updates/issues for the tlan driver I need to check up
> on. Hopefully I'll have some sparetime within a reasonable future to address
> this.

The adapter ROM must be enabled for the driver work? I'm asking this
because lspci -v shows that the adapter ROM in both ports is "disabled".

> BTW. The project page on compaq.com is the "new" tlan site.

Could you the group membership issues on the site? I'd like to see the
bug reports but I can't do it. Check the site for the actual messages
without logging in.

> Thanks,
> 
> Torben Mathiasen

Thanks also!

Paulo

-- 
Now I want you to remember that no bastard ever won a war by
dying for his country. He won it by making the other poor dumb 
bastard die for his country.

(Gen. George S. Patton Jr.)
