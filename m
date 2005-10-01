Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVJALjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVJALjq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 07:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVJALjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 07:39:46 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:1299 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750801AbVJALjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 07:39:45 -0400
Date: Sat, 1 Oct 2005 13:39:58 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andrew Morton <akpm@osdl.org>, "J.A. Magallon" <jamagallon@able.es>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: one more oops on sensor modules removal
Message-Id: <20051001133958.522c85d6.khali@linux-fr.org>
In-Reply-To: <20050920225647.167325f7.akpm@osdl.org>
References: <20050916022319.12bf53f3.akpm@osdl.org>
	<20050921004230.64ed395d@werewolf.able.es>
	<20050920225647.167325f7.akpm@osdl.org>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, J.A.,

> Is 2.6.14-rc2 OK?
> 
> Please send the .config.

No follow-up? I wasn't able to reproduce the problem (tried on two
different systems, with several kernels each time). I consider it
solved until someone can reproduce it and explain exactly how to
trigger it.

-- 
Jean Delvare
