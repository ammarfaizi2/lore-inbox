Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318774AbSILXIO>; Thu, 12 Sep 2002 19:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318743AbSILXIN>; Thu, 12 Sep 2002 19:08:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60865 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318774AbSILXHe>;
	Thu, 12 Sep 2002 19:07:34 -0400
Date: Thu, 12 Sep 2002 16:04:11 -0700 (PDT)
Message-Id: <20020912.160411.66846285.davem@redhat.com>
To: bart.de.schuymer@pandora.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ebtables - Ethernet bridge tables, for 2.5.34
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209120836.52062.bart.de.schuymer@pandora.be>
References: <20020911223252.GA12517@erik.ca>
	<20020911.153132.63843642.davem@redhat.com>
	<200209120836.52062.bart.de.schuymer@pandora.be>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Bart De Schuymer <bart.de.schuymer@pandora.be>
   Date: Thu, 12 Sep 2002 08:36:52 +0200

   ARP filtering

People should use ARP tables for arp filtering, that is why I wrote
it.  ARP filtering should not need to be bridge specific.

Next, has Lennert Buytenhek, the bridging maintainer, approved of your
changes to the bridging layer APIs?
