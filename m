Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbSLHUhK>; Sun, 8 Dec 2002 15:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbSLHUhK>; Sun, 8 Dec 2002 15:37:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:34184 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261333AbSLHUhJ>;
	Sun, 8 Dec 2002 15:37:09 -0500
Date: Sun, 08 Dec 2002 12:41:00 -0800 (PST)
Message-Id: <20021208.124100.71913406.davem@redhat.com>
To: torvalds@transmeta.com
Cc: george@mvista.com, jim.houston@ccur.com, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, anton@samba.org, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0212061111090.1489-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0212060944030.23118-100000@home.transmeta.com>
	<Pine.LNX.4.44.0212061111090.1489-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Fri, 6 Dec 2002 11:20:26 -0800 (PST)

   I did the nanosleep() implementation using the new infrastructure now, and
   am pushing it out as I write this.
 ...   
   Compat people can hopefully fix it up.

I'm fixing this up right now.
