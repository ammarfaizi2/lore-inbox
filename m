Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289308AbSA2Nss>; Tue, 29 Jan 2002 08:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289328AbSA2Ns3>; Tue, 29 Jan 2002 08:48:29 -0500
Received: from ns.suse.de ([213.95.15.193]:4357 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289307AbSA2NsH>;
	Tue, 29 Jan 2002 08:48:07 -0500
Date: Tue, 29 Jan 2002 14:47:53 +0100
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mingo@elte.hu, Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@suse.de>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020129144753.D9149@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, mingo@elte.hu,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@suse.de>
In-Reply-To: <Pine.LNX.4.33.0201291603520.7176-100000@localhost.localdomain> <E16VYVH-0003x8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16VYVH-0003x8-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jan 29, 2002 at 01:40:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 01:40:50PM +0000, Alan Cox wrote:
 > 
 > No you merely aren't watching. Most of the maintainers btw are ignoring 2.5
 > if you do some asking. And a measurable number of the listed maintainer
 > addresses just bounce.
 
 That's something that should really be fixed.
 I believe a while back someone was going to send a ping to all
 the listed addresses in MAINTAINERS. Doing this again may not
 be a bad idea.

 > There never will be maintainers proper for large amounts of stuff, and the
 > longer Linus deletes and ignores everything from someone new the less people
 > will bother sending to him. Just look at the size of the diff set between all
 > the vendor kernels and Linus 2.4.x trees before the giant -ac merge.

 Now that we have an open development branch again, perhaps its
 time for a lot of the things that have been proven stable in vendor
 kernels for a long time to get a looksee in mainline.
 Some things I feel will likely still be vendor-kernel only for some time.
 And some of them, rightly so.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
