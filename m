Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTDNTkp (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbTDNTko (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:40:44 -0400
Received: from main.gmane.org ([80.91.224.249]:16811 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263759AbTDNTkk (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 15:40:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Pirhonen <upi@gandalf.ipv6.papat.org>
Subject: Re: Linux on Unisys Aquanta HR/6 ?
Date: Mon, 14 Apr 2003 22:27:10 +0300
Message-ID: <slrnb9m2se.1ti.upi@blah.campus.papat.org>
References: <Pine.GSO.4.44.0304141114040.12734-100000@math.ut.ee> <1050323228.25353.46.camel@dhcp22.swansea.linux.org.uk>
Reply-To: upi@iki.fi
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Apr 2003 13:27:09 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Llu, 2003-04-14 at 09:20, Meelis Roos wrote:
>> Has anyone had any sucess running Linux on Unisys Aquanta HR/6 (or HR/6U
>> if that matters)? This is a up to 6-way PPro SMP machine,
>> http://www.unimetrix.com/hr6.html is the best description I have.
> 
> I can't help thinking a single AMD duron would outrun it. 

Absolutely true, but you cannot afford to have 4-way 2+Ghz P4 Xeon at
home easily. Those are cheap machines to get more that 2-way SMP for
tweaking with scalability. I have 2 quad-PPRO 'in my collection' and
those are the 'pearls of it'. One that i'd really like to have is that
8-way NCR WorldMark PPRO, but those are rare (i have spotted one tho,
but it's still on production).

Heck. Now we (i) am talking about these babies, i even have 3-way P166
SMP machine which is working just fine :)

Still, when we talk about compiling kernel and like, i prefer 2Ghz
athlon or something over quad-PPRO as it's still running loops around
any old stuff while compiling.

> 
> For Linux support the big thing you need to know is if the system
> is "Intel MP 1.1/1.4 compliant".  A lot of the ppro boxes were,
> but 6 ways can be a bit strange (the ALR 6x6 does work )
> 

Aquanta should be exactly 6x6 motherboard w/ different BIOS.


-- 
upi@iki.fi -- http://www.iki.fi/upi/

