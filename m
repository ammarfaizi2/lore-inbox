Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311548AbSCNGkG>; Thu, 14 Mar 2002 01:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311527AbSCNGjz>; Thu, 14 Mar 2002 01:39:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:22671 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311529AbSCNGjf>;
	Thu, 14 Mar 2002 01:39:35 -0500
Date: Wed, 13 Mar 2002 22:37:00 -0800 (PST)
Message-Id: <20020313.223700.73652438.davem@redhat.com>
To: greearb@candelatech.com
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 and BitKeeper
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C904437.7080603@candelatech.com>
In-Reply-To: <Pine.LNX.4.21.0203140141450.4725-100000@freak.distro.conectiva>
	<3C904437.7080603@candelatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Wed, 13 Mar 2002 23:33:27 -0700

   I tried:
   
     bk clone bk://linux24.bkbits.net//linux-2.4
   
   and
   
     bk clone bk://linux24.bkbits.net///linux-2.4
   
   But it does not work.

Try a single /, ie:

     bk clone bk://linux24.bkbits.net/linux-2.4

I know this works because I've cloned a tree using
that already :-)

Franks a lot,
David S. Miller
davem@redhat.com
