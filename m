Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287770AbSANQuW>; Mon, 14 Jan 2002 11:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287731AbSANQuQ>; Mon, 14 Jan 2002 11:50:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42391 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S287770AbSANQtg>;
	Mon, 14 Jan 2002 11:49:36 -0500
Date: Mon, 14 Jan 2002 08:48:16 -0800 (PST)
Message-Id: <20020114.084816.07038642.davem@redhat.com>
To: greearb@candelatech.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Multi-packet read/write for packet sockets?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C4309EC.3090805@candelatech.com>
In-Reply-To: <3C430323.6060707@candelatech.com>
	<20020114.082621.105170691.davem@redhat.com>
	<3C4309EC.3090805@candelatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Mon, 14 Jan 2002 09:40:12 -0700

   Excellent...  Does anyone have a snippet of code that
   shows how this works?
   
Check the tcpdump/pcap patches on Alexey's site.
