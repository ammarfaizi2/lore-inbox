Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270208AbRHGN33>; Tue, 7 Aug 2001 09:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270167AbRHGN3T>; Tue, 7 Aug 2001 09:29:19 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:33550 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S270161AbRHGN3J>; Tue, 7 Aug 2001 09:29:09 -0400
From: wichert@cistron.nl (Wichert Akkerman)
Subject: Re: Encrypted Swap
Date: 7 Aug 2001 15:29:17 +0200
Organization: Cistron Internet Services
Message-ID: <9koqfd$npd$1@picard.cistron.nl>
In-Reply-To: <20010807042810.A23855@foobar.toppoint.de> <3B6F9D78.412AB717@idb.hist.no> <20010807035828.E2399@mueller.datastacks.com> <3B6FB378.6BAD9A21@idb.hist.no>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B6FB378.6BAD9A21@idb.hist.no>,
Helge Hafting  <helgehaf@idb.hist.no> wrote:
>A relatively cheap way might be a custom pci
>card with a self-destruct RAM bank for
>storing the decryption keys.  Opening the 
>safe cause the card to zero the RAM.  

You can do that with most PC hardware these days as well, mainboards
have an enclosure sensor you can hook up for that.

Wichert.


-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |

