Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbTBTB6s>; Wed, 19 Feb 2003 20:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbTBTB6r>; Wed, 19 Feb 2003 20:58:47 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:54271 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S265063AbTBTB6q>; Wed, 19 Feb 2003 20:58:46 -0500
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  Enhance script/modpost to handle "_" prefixed symbols
References: <Pine.LNX.4.44.0302191324510.24975-100000@chaos.physics.uiowa.edu>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 20 Feb 2003 11:07:43 +0900
In-Reply-To: <Pine.LNX.4.44.0302191324510.24975-100000@chaos.physics.uiowa.edu>
Message-ID: <buo3cmj1z80.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> writes:
> I put in the following patch now, which is much simpler, yet should
> work just fine (untested);

Yes, that seems to work fine (well, at least it doesn't spew lots of
warnings like the unmodified modpost did).

Thanks,

-Miles
-- 
P.S.  All information contained in the above letter is false,
      for reasons of military security.
