Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269412AbRGaSsd>; Tue, 31 Jul 2001 14:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269414AbRGaSsV>; Tue, 31 Jul 2001 14:48:21 -0400
Received: from netcore.fi ([193.94.160.1]:32531 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S269412AbRGaSsL>;
	Tue, 31 Jul 2001 14:48:11 -0400
Date: Tue, 31 Jul 2001 21:47:57 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: <kuznet@ms2.inr.ac.ru>
cc: <therapy@endorphin.org>, <netdev@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: missing icmp errors for udp packets
In-Reply-To: <200107311833.WAA09598@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.33.0107312145350.20436-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 31 Jul 2001 kuznet@ms2.inr.ac.ru wrote:
> Hello!
>
> > If you reboot the computer, the _first_ ping/scan attempt will not return
> > icmp dest unreachable.
>
> Hmm... how fast after reboot?

Can be quite a long time.  Previously, I tested it immediately after
reboot.  Now I tried it about 6 minutes after I had typed 'reboot' with
success.

I believe it may be the first ICMP message to be sent after reboot..

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords


