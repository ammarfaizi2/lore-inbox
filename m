Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262637AbTCIVnE>; Sun, 9 Mar 2003 16:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262638AbTCIVnE>; Sun, 9 Mar 2003 16:43:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:35289 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262637AbTCIVnD>;
	Sun, 9 Mar 2003 16:43:03 -0500
Date: Sun, 09 Mar 2003 13:34:53 -0800 (PST)
Message-Id: <20030309.133453.05058422.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] obselete some atm_vcc members 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200303091235.h29CZfGi000914@locutus.cmf.nrl.navy.mil>
References: <20030308.125024.44441125.davem@redhat.com>
	<200303091235.h29CZfGi000914@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Sun, 09 Mar 2003 07:35:41 -0500

   In message <20030308.125024.44441125.davem@redhat.com>,"David S. Miller" writes:
   >This stuff was all against a tree which still had the atm_dev
   >semaphore instead of the new spinlock.  Therefore half of the patches
   >rejected and I had to put these parts in by hand.
   
   err... its the other way around?

right

