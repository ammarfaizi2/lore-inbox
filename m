Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTFTQ6B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 12:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTFTQ6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 12:58:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40578 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263487AbTFTQyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 12:54:46 -0400
Date: Fri, 20 Jun 2003 10:03:29 -0700 (PDT)
Message-Id: <20030620.100329.74736219.davem@redhat.com>
To: vinay-rc@naturesoft.net
Cc: marcelo@hera.kernel.org, netdev@oss.sgi.com, jbarnes@sgi.com,
       alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.21][FIX] use mod_timer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1056091000.1200.23.camel@lima.royalchallenge.com>
References: <1056091000.1200.23.camel@lima.royalchallenge.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
   Date: 20 Jun 2003 12:06:40 +0530

   Hi,
   
   This patch makes use of mod_timer instead of {del,add}_timer.
   
I applied all of the networking ones already and sent it
off the Marcelo the other day, just waiting for him to
eat it.
