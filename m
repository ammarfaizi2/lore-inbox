Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271671AbRHUNp4>; Tue, 21 Aug 2001 09:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271668AbRHUNpg>; Tue, 21 Aug 2001 09:45:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46749 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271667AbRHUNpc>;
	Tue, 21 Aug 2001 09:45:32 -0400
Date: Tue, 21 Aug 2001 06:45:34 -0700 (PDT)
Message-Id: <20010821.064534.28792688.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: jes@sunsite.dk, linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15ZBpI-0007oY-00@the-village.bc.nu>
In-Reply-To: <d3elq5a6au.fsf@lxplus015.cern.ch>
	<E15ZBpI-0007oY-00@the-village.bc.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Tue, 21 Aug 2001 14:44:16 +0100 (BST)

   Also the firmware we were including was seriously out of date, was a 
   release candidate (not a certified release) and took up tons of ram

In many cases the driver worked before, and fails to work afterwards.

I still contend that the whole driver should have been lifted
instead of leaving a crippled version there.

Later,
David S. Miller
davem@redhat.com
