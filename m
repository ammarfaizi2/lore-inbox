Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136707AbREGXKn>; Mon, 7 May 2001 19:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136703AbREGXKe>; Mon, 7 May 2001 19:10:34 -0400
Received: from james.kalifornia.com ([208.179.59.2]:8295 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S136707AbREGXKR>; Mon, 7 May 2001 19:10:17 -0400
Message-ID: <3AF71C94.7060107@kalifornia.com>
Date: Mon, 07 May 2001 15:07:16 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; rv:0.9+) Gecko/20010503
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@transmeta.com>
CC: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Wow! Is memory ever cheap!
In-Reply-To: <20010505095802.X12431@work.bitmover.com> <20010506142043.B31269@metastasis.f00f.org> <20010505194536.D14127@work.bitmover.com> <9d6qk6$i86$1@cesium.transmeta.com> <20010507115659.T14127@work.bitmover.com> <3AF6F11E.3A03050E@transmeta.com> <20010507121822.V14127@work.bitmover.com> <3AF6F5B8.42F803C1@transmeta.com> <20010507122730.A19632@work.bitmover.com> <3AF6F8A5.F556DF62@transmeta.com> <20010507124422.A19774@work.bitmover.com> <3AF6FF17.EBC6661F@transmeta.com>
Content-Type: multipart/related;
 boundary="------------080106090701070908020905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------080106090701070908020905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:

>Larry McVoy wrote:
>
>>On Mon, May 07, 2001 at 12:33:57PM -0700, H. Peter Anvin wrote:
>>
>>>Larry McVoy wrote:
>>>
>>>>>Because your original post was "yeah, Bitkeeper is a memory hog but you
>>>>>can get really cheap non-ECC RAM so just stuff your system with crappy
>>>>>RAM and be happy."
>>>>>
>>>I wasn't the one who said it, you did.  I don't have any evidence either
>>>way.
>>>
>>Err, Peter, it's starting to sound like you have some ax to grind that I
>>don't know about.  So I'll bow out of this conversation.
>>
>
>The only axe I have to grind was the obvious application myopia of your
>original post... "my application is the only one that matters."  That's
>all.
>
>	-hpa
>
<quote>

This is a 750Mhz K7 system with 1.5GB of memory in 3 512MB DIMMS.  The
DIMMS are not ECC, but we use BitKeeper here and it tells us when we
have bad DIMMS.

Guess what the memory cost?  $396.58 shipped to my door, second day air,
with a lifetime warranty.  I got it at www.memory4less.com <http://www.memory4less.com> which I found
using www.pricewatch.com <http://www.pricewatch.com>.  I have no association with either of those
places other than being a customer (i.e., this isn't advertising spam).

I'm burning it in right now, I wrote a little program which fills it
with different test patterns and then reads them back to make sure they
don't lose any bits.  Seems to be working, it's done about 30 passes.

1.5GB for $400.  Amazing.  No more whining from you guys that BitKeeper
uses too much memory  [:-)] 

$ hinv
Main memory size: 1535.9375 Mbytes
1 AuthenticAMD  processor
1 1.44M floppy drive
1 vga+ graphics device
1 keyboard
IDE devices:
    /dev/hda is a ST310211A, 9541MB w/512kB Cache, CHS=1216/255/63
SCSI devices:
    /dev/sda is a 3ware disk, model 3w-xxxx 74.541 GB
PCI bus devices:
    Host bridge: VIA Technologies VT 82C691 Apollo Pro (rev 2).
    PCI bridge: VIA Technologies VT 82C598 Apollo MVP3 AGP (rev 0).
    ISA bridge: VIA Technologies VT 82C686 Apollo Super (rev 34).
    IDE interface: VIA Technologies VT 82C586 Apollo IDE (rev 16).
    Host bridge: VIA Technologies VT 82C686 Apollo Super ACPI (rev 48).
    Ethernet controller: 3Com 3C905B 100bTX (rev 48).
    Ethernet controller: 3Com 3C905B 100bTX (rev 48).
    Ethernet controller: 3Com 3C905B 100bTX (rev 48).
    Ethernet controller: 3Com 3C905B 100bTX (rev 48).
    RAID storage controller: Unknown vendor Unknown device (rev 18).quote
    VGA compatible controller: Matrox Matrox G200 AGP (rev 1).
-- --- Larry McVoy lm at bitmover.com http://www.bitmover.com/lm

</quote>

Lets move on now.

-- 
I'd rather listen to Newton than to Mundie [MS flunkie who made a speech on
the evil-ness of open source]. He may have been dead for almost three
hundred years, but despite that he stinks up the room less.

Linus



--------------080106090701070908020905--

