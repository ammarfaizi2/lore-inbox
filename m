Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136333AbRA1Bab>; Sat, 27 Jan 2001 20:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136430AbRA1BaW>; Sat, 27 Jan 2001 20:30:22 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:11140 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S136333AbRA1BaK>;
	Sat, 27 Jan 2001 20:30:10 -0500
Message-ID: <3A737618.B32F1ED6@pobox.com>
Date: Sat, 27 Jan 2001 17:30:00 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david@linux.com>
CC: Shawn Starr <Shawn.Starr@Home.com>, Aaron Lehmann <aaronl@vitelus.com>,
        John Sheahan <john@reptechnic.com.au>, linux-kernel@vger.kernel.org
Subject: Re: ps hang in 241-pre10
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au> <20010126204324.B10046@vitelus.com> <3A72817E.CFCF0D52@pobox.com> <3A7285D4.9409E63A@linux.com> <3A7295F6.621BBEC4@Home.com> <3A731E65.8BE87D73@pobox.com> <3A7359BB.7BBEE42A@linux.com> <3A736B05.9021CA37@pobox.com> <3A7371DE.8FFE4572@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, here's the details you asked about:

Soundblaster Awe 32 sound card
Voodoo 3 pci video card
Running Xfree86-4.0.0 (rpms from 3dfx.com)
Playing unreal tournament, no special game
options, just 800x600 graphics @ 16 bits.

To recap, the symptoms (hung ps, etc) occurred
on kernel 2.4.1-pre8 + low latency patches. (but
I don't think the low latency patches had anything
to do with it, based on the other reports)

Hope this helps

jjs

David Ford wrote:

> On 2.4.0-ac12, I played music for about 30 minutes without any problems.  I started up an mpeg in xmms and it
> locked in short order.  I'm sure now that it has something to do with the graphics.  What DGA or other config
> options do you have enabled for your game?
>
> What video and sound card?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
