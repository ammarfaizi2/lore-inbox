Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130880AbQKGJnQ>; Tue, 7 Nov 2000 04:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131042AbQKGJnL>; Tue, 7 Nov 2000 04:43:11 -0500
Received: from Cantor.suse.de ([194.112.123.193]:40453 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130880AbQKGJmy>;
	Tue, 7 Nov 2000 04:42:54 -0500
Date: Tue, 7 Nov 2000 10:42:51 +0100
From: Andi Kleen <ak@suse.de>
To: Jordan Mendelson <jordy@napster.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
Message-ID: <20001107104251.B5081@gruyere.muc.suse.de>
In-Reply-To: <3A07662F.39D711AE@napster.com> <200011070428.UAA01710@pizda.ninka.net> <3A079127.47B2B14C@napster.com> <200011070533.VAA02179@pizda.ninka.net> <3A079D83.2B46A8FD@napster.com> <200011070603.WAA02292@pizda.ninka.net> <3A07A4B0.A7E9D62@napster.com> <200011070656.WAA02435@pizda.ninka.net> <3A07AC45.DCC961FF@napster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A07AC45.DCC961FF@napster.com>; from jordy@napster.com on Mon, Nov 06, 2000 at 11:16:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 11:16:21PM -0800, Jordan Mendelson wrote:
> > It is clear though, that something is messing with or corrupting the
> > packets.  One thing you might try is turning off TCP header
> > compression for the PPP link, does this make a difference?
> 
> Actually, there has been several reports that turning header compression
> does help.

What does help ? Turning it on or turning it off ? 


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
