Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279085AbRJVXYw>; Mon, 22 Oct 2001 19:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279082AbRJVXYo>; Mon, 22 Oct 2001 19:24:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13698 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279083AbRJVXY1>;
	Mon, 22 Oct 2001 19:24:27 -0400
Date: Mon, 22 Oct 2001 16:24:53 -0700 (PDT)
Message-Id: <20011022.162453.21928469.davem@redhat.com>
To: babydr@baby-dragons.com
Cc: sten@blinkenlights.nl, linux-kernel@vger.kernel.org
Subject: Re: INIT_MMAP on sparc64
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0110221917150.1522-100000@filesrv1.baby-dragons.com>
In-Reply-To: <20011021.181523.112610375.davem@redhat.com>
	<Pine.LNX.4.33.0110221917150.1522-100000@filesrv1.baby-dragons.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
   Date: Mon, 22 Oct 2001 19:18:38 -0400 (EDT)

   	Why man ! ,  Alpha does not have this limit ?  Why Sparc ?

It has to do with a combination of what OBP guarentees the boot
loader and limitations within the boot signature.

It would require a lot of SILO and kernel work to eliminate.

Franks a lot,
David S. Miller
davem@redhat.com
