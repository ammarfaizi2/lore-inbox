Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbTAPHh5>; Thu, 16 Jan 2003 02:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbTAPHh5>; Thu, 16 Jan 2003 02:37:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:32946 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262871AbTAPHh5>;
	Thu, 16 Jan 2003 02:37:57 -0500
Date: Wed, 15 Jan 2003 23:37:02 -0800 (PST)
Message-Id: <20030115.233702.38213539.davem@redhat.com>
To: roland@topspin.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix up RTM_SETLINK handling
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5265sp98kj.fsf@topspin.com>
References: <52adi1999k.fsf@topspin.com>
	<20030115.172358.66314347.davem@redhat.com>
	<5265sp98kj.fsf@topspin.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roland Dreier <roland@topspin.com>
   Date: 15 Jan 2003 17:39:40 -0800

   Added EXPORT_SYMBOL for call_netdevice_notifiers().
   
Patch applied, thanks a lot for fixing this patch up right
for me.
