Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129497AbQKMXJk>; Mon, 13 Nov 2000 18:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129178AbQKMXJa>; Mon, 13 Nov 2000 18:09:30 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:29456 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S129047AbQKMXJR>; Mon, 13 Nov 2000 18:09:17 -0500
Date: Tue, 14 Nov 2000 00:44:48 +0100 (MET)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Andrey Savochkin <saw@saw.sw.com.sg>
cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: user beancounter (was: Reserve VM for root)
In-Reply-To: <20001110183823.A23474@saw.sw.com.sg>
Message-ID: <Pine.LNX.4.30.0011140026030.20626-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Nov 2000, Andrey Savochkin wrote:

> On Thu, Nov 09, 2000 at 06:30:32PM +0100, Szabolcs Szakacsits wrote:
> > BTW, I wanted to take a look at the frequently mentioned beancounter patch,
> > here is the current state,
> > 	http://www.asp-linux.com/en/products/ubpatch.shtml
> > "Sorry, due to growing expenses for support of public version of ASPcomplete
> > we do not provide sources till first official release."
>
> That's not a place where I keep my code (and has never been :-)

Sorry, I was misguided by your earlier message at
	http://boudicca.tux.org/hypermail/linux-kernel/2000week30/0114.html
where you wrote
"Patch web page is http://www.asplinux.com.sg/install/ubpatch.html"

They are the same sites [mirrors in .us, .sg, .kr and .ru].

> ftp://ftp.sw.com.sg/pub/Linux/people/saw/kernel/user_beancounter/UserBeancounter.html
> is the right place (but it has some availability problems :-(

I've also tried two other ftp sites, none of them were available, just
as at present ...

> As for memory management, it provides a simple variant of service level
> support for
[...]

Thanks for the info, user beancounter is definitely needed but it's
a 2.5 issue and people have problems now. Ironically it seems disks
soon will be as fast as RAM, many thinks max swap space supported is
still 128 MB and they set up systems according to this, app
requirements (multimedia, etc) grows eagerly and users run out of
much easier then earlier. For many the quota isn't a solution because
of performance or other reasons and Linux doesn't give them any chance
to survive such a situation.

	Szaka

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
