Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbSLUH0g>; Sat, 21 Dec 2002 02:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266771AbSLUH0g>; Sat, 21 Dec 2002 02:26:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2271 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266765AbSLUH0f>;
	Sat, 21 Dec 2002 02:26:35 -0500
Date: Fri, 20 Dec 2002 23:29:09 -0800 (PST)
Message-Id: <20021220.232909.88324816.davem@redhat.com>
To: akpm@digeo.com
Cc: kiran@in.ibm.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       dipankar@in.ibm.com
Subject: Re: [patch] Make rt_cache_stat use kmalloc_percpu
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3E0418EC.B55941EE@digeo.com>
References: <20021216192212.C26076@in.ibm.com>
	<20021220.230528.106417474.davem@redhat.com>
	<3E0418EC.B55941EE@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Fri, 20 Dec 2002 23:31:56 -0800

   "David S. Miller" wrote:
   > I can't consider this seriously until the kmalloc_percpu stuff
   > actually makes it into Linus's tree.  Last I checked, Andrew had
   > a lot of legitimate gripes with the ideas.
   
   Kiran's latest (vastly simpler) version looks fine to my eye.
   
Ok, so once that is in, he can feel free to resubmit the
rt_cache_state patch.
