Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263997AbSJOTrC>; Tue, 15 Oct 2002 15:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264641AbSJOTrC>; Tue, 15 Oct 2002 15:47:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50087 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263997AbSJOTrB>;
	Tue, 15 Oct 2002 15:47:01 -0400
Date: Tue, 15 Oct 2002 12:45:40 -0700 (PDT)
Message-Id: <20021015.124540.39818748.davem@redhat.com>
To: perex@suse.cz
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: ALSA update
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0210152145240.703-100000@pnote.perex-int.cz>
References: <20021015.100811.118915540.davem@redhat.com>
	<Pine.LNX.4.33.0210152145240.703-100000@pnote.perex-int.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jaroslav Kysela <perex@suse.cz>
   Date: Tue, 15 Oct 2002 21:45:56 +0200 (CEST)

   On Tue, 15 Oct 2002, David S. Miller wrote:
   
   > It fails again soon after that, none of the ioctl32.c/pcm32.c
   > changes were even _compile_ tested.
   
   Thanks. Applied to linux-sound repository.

And what are you going to do in the future to make sure
the sound/ioctl32/ changes you submit in the future even
compile?
