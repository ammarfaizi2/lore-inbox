Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262975AbTCLAO5>; Tue, 11 Mar 2003 19:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261730AbTCLAOd>; Tue, 11 Mar 2003 19:14:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:50409 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261729AbTCLAMx>;
	Tue, 11 Mar 2003 19:12:53 -0500
Date: Tue, 11 Mar 2003 16:23:23 -0800 (PST)
Message-Id: <20030311.162323.94095868.davem@redhat.com>
To: shemminger@osdl.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] (8/8) Kill brlock
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1047428123.15872.113.camel@dell_ss3.pdx.osdl.net>
References: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
	<1047428123.15872.113.camel@dell_ss3.pdx.osdl.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Hemminger <shemminger@osdl.org>
   Date: 11 Mar 2003 16:15:23 -0800

   Previous patches killed all remaining uses of brlock so bye.
   
I'm all for this once patch 2/8 gets fixed up :-)

So what is the new way to say "stop all incoming packet
processing while I update data structure X"?
