Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291272AbSCMANh>; Tue, 12 Mar 2002 19:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291291AbSCMAN2>; Tue, 12 Mar 2002 19:13:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11649 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291279AbSCMANS>;
	Tue, 12 Mar 2002 19:13:18 -0500
Date: Tue, 12 Mar 2002 16:10:57 -0800 (PST)
Message-Id: <20020312.161057.18308390.davem@redhat.com>
To: beezly@beezly.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dropped packets on SUN GEM
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1015978127.2653.49.camel@monkey>
In-Reply-To: <1015976181.2652.30.camel@monkey>
	<20020312.155238.21594857.davem@redhat.com>
	<1015978127.2653.49.camel@monkey>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Beezly <beezly@beezly.org.uk>
   Date: 13 Mar 2002 00:08:47 +0000
   
   Also, just to clarify (i wasn't clear earlier), this host is connected
   via 1000Mbps full-duplex fibre to the switch.

The fibre port on the switch should be enabling pause then.
It doesn't make any sense for a switch highend enough to have
a fibre port yet not support and negotiate pause.

You told me ealier that "sometimes pause is on, sometimes
not".  Today you told me "pause is not going on".  Please,
which is it? :)

Do you have any manuals on the switch so we can check this
out?
