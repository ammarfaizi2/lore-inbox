Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268970AbRG0VHA>; Fri, 27 Jul 2001 17:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268972AbRG0VGv>; Fri, 27 Jul 2001 17:06:51 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:48822 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S268970AbRG0VGk>;
	Fri, 27 Jul 2001 17:06:40 -0400
Date: Fri, 27 Jul 2001 22:49:46 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Hans Reiser <reiser@namesys.com>
Cc: bvermeul@devel.blackstar.nl, kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010727224946.C6357@fuji.laendle>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	bvermeul@devel.blackstar.nl, kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107271653210.12396-100000@devel.blackstar.nl> <3B618AE4.983439DC@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3B618AE4.983439DC@namesys.com>; from reiser@namesys.com on Fri, Jul 27, 2001 at 07:38:12PM +0400
X-Operating-System: Linux version 2.4.5-pre4 (root@cerebro) (gcc version 2.95.2.1 19991024 (release)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 07:38:12PM +0400, Hans Reiser <reiser@namesys.com> wrote:
> not write garbage, has been present in most Unix filesystems for about 25 years of Unix history.  It
> is not that we are deviant on this, it is that a tradeoff is made, and for most but not all users it
> is a good one to make.

it just happens muchg more with reiserfs than with other fs's. but I trust
chreis mason who said that this might be fixable. so it might not be a design
trade-off at all.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
