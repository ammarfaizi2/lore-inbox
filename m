Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272063AbRHVSD0>; Wed, 22 Aug 2001 14:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272070AbRHVSDQ>; Wed, 22 Aug 2001 14:03:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8876 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272063AbRHVSDE>;
	Wed, 22 Aug 2001 14:03:04 -0400
Date: Wed, 22 Aug 2001 11:03:16 -0700 (PDT)
Message-Id: <20010822.110316.57459277.davem@redhat.com>
To: kakadu_croc@yahoo.com
Cc: bcrl@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: brlock_is_locked()?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010822180056.58350.qmail@web10902.mail.yahoo.com>
In-Reply-To: <Pine.LNX.4.33.0108221231260.19638-100000@touchme.toronto.redhat.com>
	<20010822180056.58350.qmail@web10902.mail.yahoo.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Brad Chapman <kakadu_croc@yahoo.com>
   Date: Wed, 22 Aug 2001 11:00:56 -0700 (PDT)

   	I'm not talking about _who_ owns the lock, I'm talking about whether
   the lock itself is locked. I don't care which process is using the lock;
   I just want to know if _somebody_ is using it. Is this possible?

Show a valid use for such a boolean state, then
the discussion may proceed :-)

Later,
David S. Miller
davem@redhat.com
