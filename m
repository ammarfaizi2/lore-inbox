Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131337AbRANPX4>; Sun, 14 Jan 2001 10:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131636AbRANPXq>; Sun, 14 Jan 2001 10:23:46 -0500
Received: from Cantor.suse.de ([194.112.123.193]:46599 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131337AbRANPXe>;
	Sun, 14 Jan 2001 10:23:34 -0500
Date: Sun, 14 Jan 2001 16:23:31 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 + iproute2
Message-ID: <20010114162331.A25726@gruyere.muc.suse.de>
In-Reply-To: <20010114124659.A23188@gruyere.muc.suse.de> <Pine.LNX.4.30.0101141309160.16758-100000@jdi.jdimedia.nl> <20010114133140.A23640@gruyere.muc.suse.de> <14945.42633.188963.984765@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14945.42633.188963.984765@pizda.ninka.net>; from davem@redhat.com on Sun, Jan 14, 2001 at 05:15:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 05:15:53AM -0800, David S. Miller wrote:
> 
> Andi Kleen writes:
>  > David's /proc/errno_strings
> 
> David put a smiley at the end of that sentence, he was kidding and was
> trying to show you how rediculious keeping errno strings in the kernel
> is.

You think it is less ridiculous than that?

/usr/src/linux/net/sched% grep EINVAL *.c | wc -l
    122


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
