Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261826AbSJDV0W>; Fri, 4 Oct 2002 17:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261837AbSJDV0W>; Fri, 4 Oct 2002 17:26:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60640 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261826AbSJDV0V>;
	Fri, 4 Oct 2002 17:26:21 -0400
Date: Fri, 04 Oct 2002 14:24:28 -0700 (PDT)
Message-Id: <20021004.142428.101875902.davem@redhat.com>
To: greearb@candelatech.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: tg3 and Netgear GA302T x 2 locks machine
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D9D16D9.7040008@candelatech.com>
References: <3D9D16D9.7040008@candelatech.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Thu, 03 Oct 2002 21:19:37 -0700

   Got my two new Netgear GA302t nics today.  They seem to use the
   tg3 driver....
   
   I put them into the 64/66 slots on my Tyan dual amd motherboard..
   Running kernel 2.4.20-pre8
   
You reported the other week problems with two Acenic's in
this same machine right?  The second Acenic wouldn't even probe
properly.  And the two Acenic's were identical.

I see a pattern developing... :-)
