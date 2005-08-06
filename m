Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263263AbVHFRCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263263AbVHFRCV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 13:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbVHFRCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 13:02:20 -0400
Received: from xenotime.net ([66.160.160.81]:52617 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S263263AbVHFRCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 13:02:19 -0400
Date: Sat, 6 Aug 2005 10:02:13 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc5-git4 __handle_mm_fault
Message-Id: <20050806100213.29c57071.rdunlap@xenotime.net>
In-Reply-To: <20050806102853.GA5083@aragorn.home.lxtec.de>
References: <20050806102853.GA5083@aragorn.home.lxtec.de>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Aug 2005 12:28:53 +0200 Elimar Riesebieter wrote:

> Hi,
> 
> tried to build mol-modules on my powerbook:
>   MODPOST
> *** Warning: "__handle_mm_fault"
> [/usr/src/modules/mol/src/kmod/Linux/../build/mol.ko] undefined!
> 
> please cc me as I am not subscribed.


http://marc.theaimsgroup.com/?l=linux-kernel&m=112328558006148&w=2

Can you test/verify that it works?

---
~Randy
