Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129449AbQLNPcV>; Thu, 14 Dec 2000 10:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132012AbQLNPcL>; Thu, 14 Dec 2000 10:32:11 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:48391 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130570AbQLNPcA> convert rfc822-to-8bit; Thu, 14 Dec 2000 10:32:00 -0500
Date: Thu, 14 Dec 2000 16:00:48 +0100
From: Martin Macok <martin.macok@underground.cz>
To: David Riley <oscar@the-rileys.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12 randomly hangs up
Message-ID: <20001214160048.A1355@sarah.kolej.mff.cuni.cz>
In-Reply-To: <20001213105153.A6624@sarah.kolej.mff.cuni.cz> <3A37F7B7.1A207AB7@the-rileys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A37F7B7.1A207AB7@the-rileys.net>; from oscar@the-rileys.net on Wed, Dec 13, 2000 at 05:27:03PM -0500
X-Echelon: GRU NSA GCHQ KGB CIA nuclear conspiration war weapon spy agent
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2000 at 05:27:03PM -0500, David Riley wrote:
> > DMESG:   http://kocour.ms.mff.cuni.cz/~macok/kernel/dmesg (Abit
> > PX5, P166 (ovrclckd to 166), 128MB RAM, 2x IDE HDD, 3com509b ISA,
> > Opti931)
> 
> Overclocking is a guaranteed way to get random hangups.  Put it back
> to its recommended clock and it might work fine.  Keep in mind that
> while this may not have shown up before, overclocking gradually
> degrades a processor's stability (trust me, I ran several 486 and
> pentiums and even a k6-2 down to where they wouldn't even work at
> the normal clock).  Try sticking it back to normal.

I know it, but it's P150 overclocked to 166 and it can run even on 200
with 2.4.0-test11 and 2.2.x for several weeks without hanging up. But it
hangs up with -test12 several minutes after I start X server and
several people have already confirm that ...

(I'm going to try latest -test13-pre ... I cannot see Changelog or
test13.log anywhere ...)

Have a nice day

(Thank you for Cc:'ing me, I'm not subscribed)

-- 
   Martin Maèok
  underground.cz
    openbsd.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
