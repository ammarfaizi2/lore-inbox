Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264509AbSIQTjg>; Tue, 17 Sep 2002 15:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264512AbSIQTjg>; Tue, 17 Sep 2002 15:39:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35202 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264509AbSIQTjg>;
	Tue, 17 Sep 2002 15:39:36 -0400
Date: Tue, 17 Sep 2002 12:35:33 -0700 (PDT)
Message-Id: <20020917.123533.107858767.davem@redhat.com>
To: bart.de.schuymer@pandora.be
Cc: buytenh@math.leidenuniv.nl, linux-kernel@vger.kernel.org
Subject: Re: bridge-netfilter patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209172110.06121.bart.de.schuymer@pandora.be>
References: <200209162341.17032.bart.de.schuymer@pandora.be>
	<20020916.162123.116935622.davem@redhat.com>
	<200209172110.06121.bart.de.schuymer@pandora.be>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Bart De Schuymer <bart.de.schuymer@pandora.be>
   Date: Tue, 17 Sep 2002 21:10:06 +0200
   
   Then we can remove the memcpy from ip_fragment(). Does that make sense?

That sounds like the kind of solution I'd like used.
