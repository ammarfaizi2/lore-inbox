Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752206AbWCJLe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbWCJLe5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 06:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbWCJLe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 06:34:57 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23688
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751991AbWCJLe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 06:34:56 -0500
Date: Fri, 10 Mar 2006 03:34:53 -0800 (PST)
Message-Id: <20060310.033453.53342192.davem@davemloft.net>
To: dim@openvz.org
Cc: arnd@arndb.de, akpm@osdl.org, dev@openvz.org,
       netfilter-devel@lists.netfilter.org, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, devel@openvz.org
Subject: Re: [PATCH] {get|set}sockopt compatibility layer
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200603101421.10920.dim@openvz.org>
References: <200603091324.00362.dim@openvz.org>
	<20060309.152934.99760924.davem@davemloft.net>
	<200603101421.10920.dim@openvz.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Mishin <dim@openvz.org>
Date: Fri, 10 Mar 2006 14:21:10 +0300

> This patch extends {get|set}sockopt compatibility layer in order to move 
> protocol specific parts to their place and avoid  huge universal net/compat.c 
> file in the future.
> 
> Signed-off-by: Dmitry Mishin <dim@openvz.org>

Applied, thanks Dmitry.

Please give "-p1" format patches in the future, I fixed your's
up by hand so could feed it to git.

Thanks again.
