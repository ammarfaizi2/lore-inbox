Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWF2NQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWF2NQV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 09:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWF2NQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 09:16:21 -0400
Received: from canuck.infradead.org ([205.233.218.70]:62370 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750758AbWF2NQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 09:16:20 -0400
Subject: Re: unused fs/jffs2/acl.c:jffs2_clear_acl()
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: jffs-dev@axis.com, linux-kernel@vger.kernel.org,
       KaiGai Kohei <kaigai@ak.jp.nec.com>
In-Reply-To: <20060629130133.GC29056@stusta.de>
References: <20060629130133.GC29056@stusta.de>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 14:16:10 +0100
Message-Id: <1151586970.16413.16.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-29 at 15:01 +0200, Adrian Bunk wrote:
> it might not have been intended that jffs2_clear_acl() in Linus' tree
> is unused?

I suspect you're right -- thanks for pointing it out.

Kaigai-san?

-- 
dwmw2

