Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130606AbQKGJmG>; Tue, 7 Nov 2000 04:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130645AbQKGJlq>; Tue, 7 Nov 2000 04:41:46 -0500
Received: from Cantor.suse.de ([194.112.123.193]:15621 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130606AbQKGJlk>;
	Tue, 7 Nov 2000 04:41:40 -0500
Date: Tue, 7 Nov 2000 10:41:36 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: jordy@napster.com, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
Message-ID: <20001107104136.A5081@gruyere.muc.suse.de>
In-Reply-To: <3A079127.47B2B14C@napster.com> <200011070533.VAA02179@pizda.ninka.net> <3A079D83.2B46A8FD@napster.com> <200011070603.WAA02292@pizda.ninka.net> <3A07A4B0.A7E9D62@napster.com> <200011070656.WAA02435@pizda.ninka.net> <3A07AC45.DCC961FF@napster.com> <200011070712.XAA02511@pizda.ninka.net> <3A07B01A.1E70EE20@napster.com> <200011070727.XAA02574@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011070727.XAA02574@pizda.ninka.net>; from davem@redhat.com on Mon, Nov 06, 2000 at 11:27:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 11:27:54PM -0800, David S. Miller wrote:
> What 2.4.x is doing is completely legal.  Really, even if not all of
> these people are from Earthlink (well, you should see if this is for
> certain) they may all be using the same buggy terminal server at these
> different ISPs.

I think such a theory would at least need verifying (e.g. by a sniffer
on the windows end that checks checksums or someone finding the checksum
failed counters windows probably maintains) 

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
