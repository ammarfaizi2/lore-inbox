Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261224AbSKGPMQ>; Thu, 7 Nov 2002 10:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbSKGPMQ>; Thu, 7 Nov 2002 10:12:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21145 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261224AbSKGPMO>;
	Thu, 7 Nov 2002 10:12:14 -0500
Date: Thu, 07 Nov 2002 07:18:08 -0800 (PST)
Message-Id: <20021107.071808.43409100.davem@redhat.com>
To: ahu@ds9a.nl
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: IPSEC FIRST LIGHT! (by non-kernel developer :-))
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021107141219.GA28791@outpost.ds9a.nl>
References: <20021107130244.GA25032@outpost.ds9a.nl>
	<20021107.052114.123991710.davem@redhat.com>
	<20021107141219.GA28791@outpost.ds9a.nl>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: bert hubert <ahu@ds9a.nl>
   Date: Thu, 7 Nov 2002 15:12:19 +0100
   
   By the way, is tunnel mode there yet?
   
   Does it require more than setkey? Or does it need pseudo devices, GRE or
   anything? Just setting up tunnel mode doesn't appear to work - nothing gets
   crypted or signed.

Alexey, any ideas?
