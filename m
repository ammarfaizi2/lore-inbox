Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTFTRA1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 13:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTFTQ6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 12:58:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43906 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263496AbTFTQ41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 12:56:27 -0400
Date: Fri, 20 Jun 2003 10:05:00 -0700 (PDT)
Message-Id: <20030620.100500.41646097.davem@redhat.com>
To: jmorris@intercode.com.au
Cc: vinay-rc@naturesoft.net, marcelo@hera.kernel.org, netdev@oss.sgi.com,
       jbarnes@sgi.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.21][FIX] use mod_timer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Mutt.LNX.4.44.0306201907450.27218-100000@excalibur.intercode.com.au>
References: <1056091000.1200.23.camel@lima.royalchallenge.com>
	<Mutt.LNX.4.44.0306201907450.27218-100000@excalibur.intercode.com.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Morris <jmorris@intercode.com.au>
   Date: Fri, 20 Jun 2003 19:10:50 +1000 (EST)
   
   FYI, the status of the networking patches is:
   
                        2.5-bk   2.4.21-ac1    2.4-bk
   net/core/dst.c        yes        no           no
   net/sched/sch_cbq.c   yes       yes           no
   net/sched/sch_csz.c   yes       yes           no
   net/sched/sch_htb.c   yes       yes           no

They are, however, in my BK tree and I did attempt to push
them to Marcelo so nights ago.
