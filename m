Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbTDZDWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 23:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263867AbTDZDWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 23:22:17 -0400
Received: from dc-mx16.cluster1.charter.net ([209.225.8.26]:46998 "EHLO
	mx16.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261302AbTDZDWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 23:22:17 -0400
Date: Fri, 25 Apr 2003 23:34:23 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: amd74xx+nForce2+DMA+CD writing = hang
Message-ID: <20030426033423.GA12251@charter.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200304260345.36108.renaud@renaudguerin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304260345.36108.renaud@renaudguerin.net>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.4.20-ck6 i686
X-Processor: Athlon XP 2000+
X-Uptime: 23:31:14 up 4 days, 21:41,  3 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/1.5.4i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Sat, Apr 26, 2003 at 03:45:36AM +0200, Renaud Gu?rin wrote:
>
> BTW, before this can be fixed, how does one disable DMA for a particular 
> device on the kernel cmdline ?
> 

CONFIG_IDEDMA_ONLYDISK=y
