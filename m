Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbUAXVYV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 16:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbUAXVYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 16:24:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41147 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262164AbUAXVYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 16:24:18 -0500
Date: Sat, 24 Jan 2004 13:14:45 -0800 (PST)
Message-Id: <20040124.131445.48521788.davem@redhat.com>
To: jgarzik@pobox.com
Cc: grundler@parisc-linux.org, jgarzik@redhat.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] 2.6.1 tg3 DMA engine test failure
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <4012E071.2080704@pobox.com>
References: <20040124073032.GA7265@colo.lackof.org>
	<20040123.233241.59493446.davem@redhat.com>
	<4012E071.2080704@pobox.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@pobox.com>
   Date: Sat, 24 Jan 2004 16:15:29 -0500

   There were two separate components to Grant's patch (hint ggg... split 
   up your patches).
   
   What do you think about GRC-resets-sub-components part?
   
   That appears valid (and probably wise) to me, but correct me if I'm wrong...

I know, I tried to give the impression that I was fine with Grant's
patch besides the ALL_BE bit part.

I'll take care of further reviewing and merging this around Jeff.
