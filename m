Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293720AbSB1UwP>; Thu, 28 Feb 2002 15:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293734AbSB1Ust>; Thu, 28 Feb 2002 15:48:49 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:48513 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293733AbSB1UqP>;
	Thu, 28 Feb 2002 15:46:15 -0500
Message-ID: <3C7EA328.1B2E0070@vnet.ibm.com>
Date: Thu, 28 Feb 2002 15:37:44 -0600
From: Tom Gall <tom_gall@vnet.ibm.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: POP patches for Teron CX
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

  For those interested in living on the bleeding edge and have the scars
to show for it I offer the following bit code.

 
ftp://ftp.kernel.org/pub/linux/kernel/people/tgall/pop/pop/pop-0.9.1-patch.gz

  Apply against stock 2.4.18
  
  POP as some of you may or may not know is an effort underway by a
number of parties to produce a low cost PowerPC based motherboard. Since
a couple of evaluation boards are available and commercial boards are
just around the corner I thought I'd post this. This code is
experimental, don't nag me for content, quality, or code format. It's
meant to work, that's it. Bigger hammer technology at it's best. The
next patch will contain the proper board detection code.

  A *LARGE* portion of the patch is bringing 2.4.18 sources up to the
level of the ppc _devel bk tree. Unfortunate but necessary.

  Enjoy,

  Tom

-- 
Tom Gall - [embedded] [PPC64 | PPC32] Code Monkey
Peace, Love &                  "Where's the ka-boom? There was
Linux Technology Center         supposed to be an earth
http://www.ibm.com/linux/ltc/   shattering ka-boom!"
(w) tom_gall@vnet.ibm.com       -- Marvin Martian
(w) 507-253-4558
(h) tgall@rochcivictheatre.org
