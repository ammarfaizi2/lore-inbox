Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271132AbRHYUrF>; Sat, 25 Aug 2001 16:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271135AbRHYUq4>; Sat, 25 Aug 2001 16:46:56 -0400
Received: from mx5.port.ru ([194.67.57.15]:3342 "EHLO mx5.port.ru")
	by vger.kernel.org with ESMTP id <S271132AbRHYUqv>;
	Sat, 25 Aug 2001 16:46:51 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: unrelated 2.4.x (x=0-9) sound
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.27.212]
Date: Sat, 25 Aug 2001 20:47:02 +0000 (GMT)
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15akKc-0007KZ-00@f8.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     hello guys...
    this time it is not a crash, just a misfeature... ;)
    i`m used to have the following issue:
  sound clicks and flakiness while scrolling console
  text in mc. 

    less is also hit by this issue, but this is some
  strange: if in mc case _each_ keypress produce
  clicks, in less case only the first scrollup
  after switching to less` console does...

    important detail: it clicks *much* more when
  scrolling up (when scrolling down, clicks are quite
  hard to realize).

    one more important detail: for me it is quite
  _annoyingly_ reproducible... ;)

    this behaviour is seen by me on two boxes:
  p166/24M/Zida 2dvx/s3V+/sb16_genuine
  5x86-150/12M/Asus SP4G/trident 512/es688

    also the load _while_ playing mp3 _and_ scrolling
  is ~60% on p166 (not 100% i mean).

    this doesnt depend on the nature of sound, ie
  if sound source is plain wav, which doesnt use cpu,
  these clicks are here, not more, not less...

    something makes me think/remember that this is not
  the case on 2.2.x, but i`m far not sure...

---


cheers,


   Samium Gromoff
