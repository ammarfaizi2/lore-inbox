Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293183AbSCEOIr>; Tue, 5 Mar 2002 09:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293155AbSCEOIj>; Tue, 5 Mar 2002 09:08:39 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5250 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293151AbSCEOIN>;
	Tue, 5 Mar 2002 09:08:13 -0500
Date: Tue, 05 Mar 2002 06:06:04 -0800 (PST)
Message-Id: <20020305.060604.68157839.davem@redhat.com>
To: linux-kernel@vger.kernel.org, tlan@stud.ntnu.no
Cc: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: Re: [BETA-0.95] Sixth test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020305.060323.99455532.davem@redhat.com>
In-Reply-To: <20020305.055204.44939648.davem@redhat.com>
	<20020305150204.A7174@stud.ntnu.no>
	<20020305.060323.99455532.davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "David S. Miller" <davem@redhat.com>
   Date: Tue, 05 Mar 2002 06:03:23 -0800 (PST)
   
   How are you setting the mtu, with:
   
   /sbin/ifconfig ${DEV} mtu 9000
   
   or something like that?  Hmmm...

Wait, even more importantly are you going through a switch?

Most gigabit switches don't support 9000 byte mtu :-)

You're probably said that you're over a cross-over cable
direct connect and I've just forgotten.
