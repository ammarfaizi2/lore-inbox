Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWDOJbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWDOJbM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 05:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWDOJbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 05:31:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31456
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932354AbWDOJbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 05:31:10 -0400
Date: Sat, 15 Apr 2006 02:27:02 -0700 (PDT)
Message-Id: <20060415.022702.120267858.davem@davemloft.net>
To: samuel.ortiz@nokia.com
Cc: bunk@stusta.de, jt@hpl.hp.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] net/irda/irias_object.c: remove unused exports
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0604151157320.1032@irie>
References: <20060414114446.GL4162@stusta.de>
	<Pine.LNX.4.58.0604151157320.1032@irie>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Ortiz <samuel.ortiz@nokia.com>
Date: Sat, 15 Apr 2006 11:58:21 +0300 (EEST)

> On Fri, 14 Apr 2006, ext Adrian Bunk wrote:
> 
> > This patch removes the following unused EXPORT_SYMBOL's:
> > - irias_find_attrib
> > - irias_new_string_value
> > - irias_new_octseq_value
> >
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Looks good to me.
> 
> Signed-off-by: Samuel Ortiz <samuel.ortiz@nokia.com>

Sam, just add this to your IRDA queue.  Ok?
