Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271573AbRHUM7C>; Tue, 21 Aug 2001 08:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271651AbRHUM6x>; Tue, 21 Aug 2001 08:58:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20125 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271573AbRHUM6m>;
	Tue, 21 Aug 2001 08:58:42 -0400
Date: Tue, 21 Aug 2001 05:58:56 -0700 (PDT)
Message-Id: <20010821.055856.08326920.davem@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Qlogic/FC firmware
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Who removed it from the 2.4.x driver recently, and why?

I've been playing around, accidently corrupting my firmware
a few times, and had to grab the firmware back from older
trees to make my qlogic,FC card usable again.

Removing the firmware makes no sense, if the firmware was
incorrect for some reason, simply correct it.

Later,
David S. Miller
davem@redhat.com
