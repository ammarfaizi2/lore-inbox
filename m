Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315631AbSGFRp6>; Sat, 6 Jul 2002 13:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSGFRp5>; Sat, 6 Jul 2002 13:45:57 -0400
Received: from www.transvirtual.com ([206.14.214.140]:9226 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315631AbSGFRp4>; Sat, 6 Jul 2002 13:45:56 -0400
Date: Sat, 6 Jul 2002 10:48:19 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Brad Hards <bhards@bigpond.net.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <vojtech@twilight.ucw.cz>
Subject: Re: [patch] Typo fixes in input code
In-Reply-To: <200207061817.43224.bhards@bigpond.net.au>
Message-ID: <Pine.LNX.4.44.0207061047370.26054-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You patch is right except for drivers/input/gameport/Config.help. That was
right before your patch.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/

On Sat, 6 Jul 2002, Brad Hards wrote:

> On Sat, 6 Jul 2002 09:54, Linus Torvalds wrote:
> > More merges all over the map - ppc, scsi, USB, kbuild, input drivers etc.
> Found a few typos in the input changes. Fixup patch attached.
>
> Brad
>
> --
> http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.

