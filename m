Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261328AbTC0Ufa>; Thu, 27 Mar 2003 15:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261331AbTC0Ufa>; Thu, 27 Mar 2003 15:35:30 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60646 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261328AbTC0Uf3>;
	Thu, 27 Mar 2003 15:35:29 -0500
Date: Thu, 27 Mar 2003 12:42:46 -0800 (PST)
Message-Id: <20030327.124246.39038122.davem@redhat.com>
To: bunk@fs.tum.de
Cc: laforge@netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] fix multiple definitions of ipv6_ext_hdr
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030327204136.GY24744@fs.tum.de>
References: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva>
	<20030327204136.GY24744@fs.tum.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Adrian Bunk <bunk@fs.tum.de>
   Date: Thu, 27 Mar 2003 21:41:37 +0100

   My fix for this issue that went into 2.5.66 is below (it applies 
   and compiles against 2.4.21-pre6, too).
   
   Please apply

I'll take care of this, sorry.
