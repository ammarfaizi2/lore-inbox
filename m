Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbTDLHUg (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 03:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbTDLHUf (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 03:20:35 -0400
Received: from rth.ninka.net ([216.101.162.244]:45492 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263180AbTDLHUf (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 03:20:35 -0400
Subject: Re: [PATCH] [2.4.20] filter_list destroy fix in
	net/sched/sch_prio.c
From: "David S. Miller" <davem@redhat.com>
To: jamal <hadi@cyberus.ca>
Cc: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org,
       "Alexey N. Kuznetsov" <kuznet@ms2.inr.ac.ru>
In-Reply-To: <20030410135727.M86925@shell.cyberus.ca>
References: <E1B7C89B8DCB084C809A22D7FEB90B381773AD@frodo.avalon.ru>
	 <20030410135727.M86925@shell.cyberus.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050132725.13106.2.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Apr 2003 00:32:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 10:57, jamal wrote:
> Looks good to me.

He missed sch_csz.c, I already sent a patch I wrote for this
to Linus and Marcelo will get a copy soon'ish.

-- 
David S. Miller <davem@redhat.com>
