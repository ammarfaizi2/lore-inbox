Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262101AbSIYUI7>; Wed, 25 Sep 2002 16:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262103AbSIYUI7>; Wed, 25 Sep 2002 16:08:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53198 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262101AbSIYUI6>;
	Wed, 25 Sep 2002 16:08:58 -0400
Date: Wed, 25 Sep 2002 13:03:53 -0700 (PDT)
Message-Id: <20020925.130353.117043532.davem@redhat.com>
To: mingo@elte.hu
Cc: zaitcev@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: cmpxchg in 2.5.38
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0209252134340.17577-100000@localhost.localdomain>
References: <20020925134215.A17831@devserv.devel.redhat.com>
	<Pine.LNX.4.44.0209252134340.17577-100000@localhost.localdomain>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ingo Molnar <mingo@elte.hu>
   Date: Wed, 25 Sep 2002 21:34:59 +0200 (CEST)
   
   On Wed, 25 Sep 2002, Pete Zaitcev wrote:
   
   > OK, I'll work around the cmpxchg locally.
   
   no need, i already sent a patch that removes the cmpxchg.
   
Thanks so much.
