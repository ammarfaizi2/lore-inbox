Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262923AbRE1DIW>; Sun, 27 May 2001 23:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbRE1DIL>; Sun, 27 May 2001 23:08:11 -0400
Received: from mail.alphalink.com.au ([203.24.205.7]:58464 "EHLO
	mail.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S262923AbRE1DH6>; Sun, 27 May 2001 23:07:58 -0400
Message-ID: <3B11C358.EC8B01F7@alphalink.com.au>
Date: Mon, 28 May 2001 13:17:44 +1000
From: Greg Banks <gnb@alphalink.com.au>
X-Mailer: Mozilla 4.07 [en] (X11; I; Linux 2.2.1 i586)
MIME-Version: 1.0
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
CC: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Configure.help entries wanted
In-Reply-To: <E153pEG-0008RL-00@the-village.bc.nu> <01ce01c0e64c$b6cc01e0$52a6b3d0@Toshiba> <3B1061FC.EB18967A@alphalink.com.au> <029901c0e652$a108f740$52a6b3d0@Toshiba> <3B106BE6.78F9DCC4@alphalink.com.au> <20010527182730.A19341@bug.ucw.cz> <3B11A237.92F7CC76@alphalink.com.au> <011e01c0e722$0b08bc00$52a6b3d0@Toshiba>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaswinder Singh wrote:
> 
> What is the companion chip in DMIDA ?

  HD64465.

> IrDA and USB are working properly in linux ?

  No.  IrDA seems easy, just haven't got around to it.
USB is a major pain on the HD64465 because of the way it
deals with "host" memory.  I had a driver which initialised
the root hub at one point but haven't had time to push
it any further.

Greg.
-- 
If it's a choice between being a paranoid, hyper-suspicious global
village idiot, or a gullible, mega-trusting sheep, I don't look
good in mint sauce.                      - jd, slashdot, 11Feb2000.
