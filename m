Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261925AbRENHf1>; Mon, 14 May 2001 03:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261840AbRENHfR>; Mon, 14 May 2001 03:35:17 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:12303 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261507AbRENHfA>; Mon, 14 May 2001 03:35:00 -0400
Date: 14 May 2001 09:42:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <80qQqUQ1w-B@khms.westfalen.de>
In-Reply-To: <15103.18224.265350.877968@pizda.ninka.net>
Subject: Re: IPv6: the same address can be added multiple times
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.33.0105132319120.3026-100000@netcore.fi> <200105131759.VAA27768@ms2.inr.ac.ru> <Pine.LNX.4.33.0105132319120.3026-100000@netcore.fi> <15103.18224.265350.877968@pizda.ninka.net>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davem@redhat.com (David S. Miller)  wrote on 13.05.01 in <15103.18224.265350.877968@pizda.ninka.net>:

> Pekka Savola writes:
>  > But it still looks dirty.  Also, it's easier to add it many times by
>  > mistake; IPv4 addresses do not allow this.  And as you have to remove
>  > them N times too, this may create even more confusion.
>
> There is this growing (think growing as in "fungus") set of thinking
> that just because something can be misused, this is an argument
> against it even existing.

But that does not seem to be the argument here. Rather, it is "I can  
certainly see where this can cause harm, but I cannot see where it is  
useful for anything at all, so why do we have it?".

> I think this is wrong.  I'm seeing it a lot, especially on this list,
> and it's becomming a real concern at least to me.
>
> Most of the time the argument goes like:
>
> 1: "Well, we allow this because you can do usefull things X Y and
>     Z as a result."

What is X, Y and Z in this particular case? Nobody seems to have said  
that.

Incidentally, this thread is *very* similar to the "mount the exact same  
FS several times on the exact same mountpoint" thing. I'd expect to get a  
similar resolution (i.e., *don't* allow that).

MfG Kai
