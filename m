Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263096AbRFWOQt>; Sat, 23 Jun 2001 10:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263942AbRFWOQ3>; Sat, 23 Jun 2001 10:16:29 -0400
Received: from pa147.bialystok.sdi.tpnet.pl ([213.25.59.147]:896 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263096AbRFWOQZ>; Sat, 23 Jun 2001 10:16:25 -0400
Date: Sat, 23 Jun 2001 16:13:18 +0200
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jp@ulgo.koti.com.pl>
To: linux-kernel@vger.kernel.org
Subject: pci_fixup_via691_2 Holy Crusade
Message-ID: <20010623161318.A714@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- I am 2.4.2-ac21 and I will destroy all your divx!!! - said little egg
- How can you destroy my divx, if you are just a minor kernel version...? - I
  asked, it was first time in my life I talked to egg
- You will see!!! - said egg and disappear

>From this time - every day was sad. Whenever I run aviplay or mplayer - it
works slowly, and all movies were just a slideshow. I also asked x11perf what
it thinking about it - and it said: "your video is slow".

So I took my diff, gcc and sword and started to fight. After few hours I found
little monster, called pci_fixup_via691_2. I cut it with my sword, called Holy
Vim  - and my kernel runs fast again! 

So I wrote here about it. It was a good move, becouse next day I found in my
mailbox a Letter From God. It was short, but shine, so my dark room become
bright. The God, also known as Alan Cox said: "I will remove this bogus code,
and your life will be happy again". I heard singing of angels when I was
reading it. Then it was 2.4.4-ac2, I looked at it and I knew, that it was good. 

But, the Evil can't be defeated so easly. I was just sleeping when 2.4.5
appeared. Then today I decided to check 2.4.6-pre5 and I scared when I heard
the same laught: 
- I am here! I am still here!!! you can't kill me, couse I am internal part of
  that kernel! hahahahaaha...!!!

So, it is The Holy Crusade. If you see:

{ PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      PCI_DEVICE_ID_VIA_82C598_1,
pci_fixup_via691_2 },

remember - it's an Evil Line From Hell. If you have VIA MVP3 (like me) you must
taste its blood every time you compile new _stable_ kernel. Remember about it.
Good Night!
