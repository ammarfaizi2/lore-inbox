Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280341AbRJaRed>; Wed, 31 Oct 2001 12:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280335AbRJaReT>; Wed, 31 Oct 2001 12:34:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17028 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280345AbRJaRdS>;
	Wed, 31 Oct 2001 12:33:18 -0500
Date: Wed, 31 Oct 2001 09:29:54 -0800 (PST)
Message-Id: <20011031.092954.115906622.davem@redhat.com>
To: alex.buell@tahallah.demon.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [sparc] Weird ioctl() bug in 2.2.19 (fwd)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0110311040180.10416-100000@tahallah.demon.co.uk>
In-Reply-To: <Pine.LNX.4.33.0110311040180.10416-100000@tahallah.demon.co.uk>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alex Buell <alex.buell@tahallah.demon.co.uk>
   Date: Wed, 31 Oct 2001 10:41:29 +0000 (GMT)

   Weird. Any ideas?
   
step 1:

  cp src/linux/include/linux/soundcard.h /usr/include/linux/soundcard.h

step 2:

  recompile your apps

Franks a lot,
David S. Miller
davem@redhat.com

