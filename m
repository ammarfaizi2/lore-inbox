Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274040AbRIXQ6Q>; Mon, 24 Sep 2001 12:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274039AbRIXQ6J>; Mon, 24 Sep 2001 12:58:09 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:34996 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S274031AbRIXQ6C>;
	Mon, 24 Sep 2001 12:58:02 -0400
Date: Mon, 24 Sep 2001 18:57:55 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Message-ID: <20010924185755.E4126@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <B0005839269@gollum.logi.net.au> <20010924173210.A7630@emma1.emma.line.org> <20010924161518.KYHD11251.femail27.sdc1.sfba.home.com@there> <20010924185303.B10117@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20010924185303.B10117@emma1.emma.line.org>
X-Operating-System: Linux version 2.4.8-ac9 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 06:53:03PM +0200, Matthias Andree <matthias.andree@stud.uni-dortmund.de> wrote:
> Linear writing as dd mostly does is BTW something which should never be
> affected by write caches.

A write cache can and will speed up linear writes on typical ide setups.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
