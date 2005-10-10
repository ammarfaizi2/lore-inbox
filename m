Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVJJD0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVJJD0y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 23:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVJJD0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 23:26:54 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13757
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932334AbVJJD0x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 23:26:53 -0400
Date: Sun, 09 Oct 2005 20:26:46 -0700 (PDT)
Message-Id: <20051009.202646.70198053.davem@davemloft.net>
To: seb@frankengul.org
Cc: debian-sparc@lists.debian.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: Sparc64 U60: no iptables
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4349614F.1010408@frankengul.org>
References: <4347A731.7010509@frankengul.org>
	<4348EFF4.3040305@frankengul.org>
	<4349614F.1010408@frankengul.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sébastien Bernard <seb@frankengul.org>
Date: Sun, 09 Oct 2005 20:28:31 +0200

> Can one explain me why this patch works on other archs, and oops on the 
> sparc64 smp ?
> Can one explain why I'm the only one to have this problem ?

On your Ultra60 the two physical cpus are numbered "0" and "2".
