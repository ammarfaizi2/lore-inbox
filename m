Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317484AbSFIAzB>; Sat, 8 Jun 2002 20:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317496AbSFIAzA>; Sat, 8 Jun 2002 20:55:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58538 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317484AbSFIAy7>;
	Sat, 8 Jun 2002 20:54:59 -0400
Date: Sat, 08 Jun 2002 17:51:08 -0700 (PDT)
Message-Id: <20020608.175108.84748597.davem@redhat.com>
To: greearb@candelatech.com
Cc: mark@mark.mielke.cc, cfriesen@nortelnetworks.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D029DAF.5040006@candelatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Sat, 08 Jun 2002 17:13:35 -0700
   
   If you're talking per-socket SNMP counters, then that could work.
   General protocol-wide counters would not help much, at least
   in my case.

Why not?  If you know where the drops are occurring, what else
do you need to know?

I'm not talking about per-socket SNMP counters, that would be
rediclious.
