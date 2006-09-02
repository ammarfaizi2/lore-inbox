Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWIBLpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWIBLpE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 07:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWIBLpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 07:45:04 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:3518 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751095AbWIBLpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 07:45:02 -0400
Message-ID: <44F96DC7.5060805@s5r6.in-berlin.de>
Date: Sat, 02 Sep 2006 13:40:55 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Philippe_Gramoull=E9?= <philippe@gramoulle.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc5-mm1
References: <20060901015818.42767813.akpm@osdl.org> <20060902090552.AF91434AC@philou.gramoulle.local>
In-Reply-To: <20060902090552.AF91434AC@philou.gramoulle.local>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Gramoullé wrote:
...
>   | ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/
> 
> 2.6.18-rc5-mm1 doesn't build whereas 2.6.18-rc5 does.
...
> arch/i386/kernel/sys_i386.c:262: error: '__NR_execve' undeclared (first use in this function)
...

Also apply the hot-fixes from above FTP link.
-- 
Stefan Richter
-=====-=-==- =--= ---=-
http://arcgraph.de/sr/

-- 
VGER BF report: H 0
