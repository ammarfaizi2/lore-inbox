Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263746AbTEOCf2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263755AbTEOCf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:35:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34208 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263746AbTEOCf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:35:27 -0400
Date: Wed, 14 May 2003 19:47:48 -0700 (PDT)
Message-Id: <20030514.194748.77044174.davem@redhat.com>
To: acme@conectiva.com.br
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] af_netlink: netlink_proto_init has to be core_initcall
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030515023550.GI6372@conectiva.com.br>
References: <20030515023550.GI6372@conectiva.com.br>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Wed, 14 May 2003 23:35:50 -0300

   	Please pull from:
   
   bk://kernel.bkbits.net/acme/net-2.5
   
   	Jens, this one fixes the problem you reported, thanks!

Pulled, thanks for fixing this bug Arnaldo.
