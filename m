Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268484AbTCCJGs>; Mon, 3 Mar 2003 04:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268490AbTCCJGs>; Mon, 3 Mar 2003 04:06:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39335 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268484AbTCCJGr>;
	Mon, 3 Mar 2003 04:06:47 -0500
Date: Mon, 03 Mar 2003 00:59:34 -0800 (PST)
Message-Id: <20030303.005934.99638648.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] let upper layer know lec supports multicast
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200302251156.h1PBu8BT030035@locutus.cmf.nrl.navy.mil>
References: <200302251156.h1PBu8BT030035@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Tue, 25 Feb 2003 06:56:09 -0500

   the ip layer uses the presence of the .set_multicast_list to determine
   if the underlying network device supports multicast.
   
Patch applied, thanks.
