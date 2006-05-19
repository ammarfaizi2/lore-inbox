Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWESNKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWESNKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 09:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWESNKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 09:10:54 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:11236 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751325AbWESNKx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 09:10:53 -0400
Message-ID: <446DC31E.4080900@aitel.hist.no>
Date: Fri, 19 May 2006 15:07:42 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
CC: linux cbon <linuxcbon@yahoo.fr>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
References: <20060518172827.73908.qmail@web26601.mail.ukl.yahoo.com> <446D8F36.3010201@aitel.hist.no> <446DA746.50506@lumumba.uhasselt.be>
In-Reply-To: <446DA746.50506@lumumba.uhasselt.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Issaris wrote:

> Hi,
>
> Helge Hafting wrote:
>
>> [...]
>> The problem with writing those 3D drivers is not complexity
>> or "historic baggage" in the X codebase.  It is the fact that
>> only the vendors know how the cards work, and most of them
>> won't tell us.
>>
>> To which the solution is:  buy the cards that work, and screw the rest. 
>
>
> Just out of curiosity: Do you know any currently sold cards that support
> XVideo, OpenGL and for which open source drivers are available?

I don't know much about XVideo.
For DRI support, look at:
http://dri.freedesktop.org/wiki/Status?action=highlight&value=CategoryHardware

Many of the cards listed there are a few years old, but several of them
are still available as cheap alternatives in shops.  I had no problem buying
a radeon 9200 and a matrox G550 for example.

Also, the VIA graphichs chips found on current mini-itx motherboards
have both opengl and mpeg2-acceleration.  A mini-itx thing is hardly what
you use as a power desktop machine, but the small size and fanless operation
means they're popular for homemade media player/entertainment boxes.

I got one in my car; mostly for playing CDs and gps navigation. But
it will also play DVDs, play tuxracer using opengl, as well as
the usual web surfing and word processing.

Helge Hafting


