Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318159AbSHSF0p>; Mon, 19 Aug 2002 01:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318161AbSHSF0p>; Mon, 19 Aug 2002 01:26:45 -0400
Received: from pool-151-197-243-188.phil.east.verizon.net ([151.197.243.188]:31873
	"EHLO porsche.genebrew.com") by vger.kernel.org with ESMTP
	id <S318159AbSHSF0l>; Mon, 19 Aug 2002 01:26:41 -0400
Message-ID: <3D60842D.7030406@genebrew.com>
Date: Mon, 19 Aug 2002 01:37:49 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel.Org bug in viewing of patches
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel.Org admins,

I was using the nifty patch viewing feature on the homepage when I 
noticed that in the per-file patch list for a given patch, the links 
generated are not correct. An example is the current ac patch view at:

http://www.kernel.org/diff/diffview.cgi?file=/pub/linux/kernel/people/alan/linux-2.4/2.4.20/patch-2.4.20-pre2-ac4.gz

Clicking on the link for drivers/net/3c59x.c actually leads to the patch 
for drivers/net/cs89x0.h. Similar problems appear to exist for viewing 
of the other patches as well, with different offsets in the file list.

Thanks for the cool viewer,
Rahul

