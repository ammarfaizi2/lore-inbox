Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275428AbRJATbC>; Mon, 1 Oct 2001 15:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275425AbRJATam>; Mon, 1 Oct 2001 15:30:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49839 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S275421AbRJATac>;
	Mon, 1 Oct 2001 15:30:32 -0400
Date: Mon, 01 Oct 2001 12:30:23 -0700 (PDT)
Message-Id: <20011001.123023.83622655.davem@redhat.com>
To: matthias.andree@stud.uni-dortmund.de
Cc: Torvalds@transmeta.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
Subject: Re: devinet.c 4.4BSD compatibility patch to ioctl SIOCGIF* for
 2.4.10
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011001121931.B15943@emma1.emma.line.org>
In-Reply-To: <20011001121931.B15943@emma1.emma.line.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
   Date: Mon, 1 Oct 2001 12:19:31 +0200

   Please apply this patch to 2.4.11-preX. It's been in -ac for
   some revisions now, and no-one has screamed or claimed it broke
   anything. It's unchanged from my 2.4.9 version, it applies cleanly
   against 2.4.10, so I'm resubmitting.

I've already submitted these changes to Linus with some cleanups
from Alexey...

Franks a lot,
David S. Miller
davem@redhat.com
