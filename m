Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265960AbSLSTJo>; Thu, 19 Dec 2002 14:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbSLSTJo>; Thu, 19 Dec 2002 14:09:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:50388 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265960AbSLSTJn>;
	Thu, 19 Dec 2002 14:09:43 -0500
Date: Thu, 19 Dec 2002 11:12:21 -0800 (PST)
Message-Id: <20021219.111221.115928165.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: maxk@qualcomm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1040326115.28973.25.camel@irongate.swansea.linux.org.uk>
References: <1040225146.1873.21.camel@localhost>
	<1040313919.2650.31.camel@localhost>
	<1040326115.28973.25.camel@irongate.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 19 Dec 2002 19:28:35 +0000

   On Thu, 2002-12-19 at 16:05, Max Krasnyansky wrote:
   > Hmm, no replies. Nobody is interested in this or what ?
   > I want to get this fixed otherwise I can't fix Bluetooth module
   > refcounting. 
   
   Looks good to me, but its christmas so I wouldnt expect much to happen
   till the new year
   
I just got back from a long snowboarding trip, I'll look at this
over the weekend before I disappear for another similar trip :)
