Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272369AbRISTjf>; Wed, 19 Sep 2001 15:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273179AbRISTj0>; Wed, 19 Sep 2001 15:39:26 -0400
Received: from a82d11hel.dial.kolumbus.fi ([212.54.29.82]:59764 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S272369AbRISTjG>; Wed, 19 Sep 2001 15:39:06 -0400
Message-ID: <3BA8F45B.7006BA1@kolumbus.fi>
Date: Wed, 19 Sep 2001 22:39:07 +0300
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac12
In-Reply-To: <20010918214907.A6707@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> o       Fix radeon + AMD761 lockup/corruption problem   (Stephen Tweedie)

OK, I got a bit farther with this. Now the GDM comes up with corrupted image
and mouse pointer moves, but the keyboard doesn't react to anything (num
lock led doesn't work when I hit numlock) and I can't do anything with
mouse.


Reiserfs is also broken (unable to mount partitions), from dmesg:

reiserfs kgetopt: there is not option


 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
