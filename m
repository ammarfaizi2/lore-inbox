Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268491AbTANBlP>; Mon, 13 Jan 2003 20:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268488AbTANBlP>; Mon, 13 Jan 2003 20:41:15 -0500
Received: from fmr01.intel.com ([192.55.52.18]:32496 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S268491AbTANBlO>;
	Mon, 13 Jan 2003 20:41:14 -0500
Subject: Re: concerns about sysfs_ops
From: Louis Zhuang <louis.zhuang@linux.co.intel.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0301130907340.1136-100000@localhost.localdomain>
References: <Pine.LNX.4.33.0301130907340.1136-100000@localhost.localdomain>
Content-Type: text/plain
Organization: Intel Crop.
Message-Id: <1042504991.10860.16.camel@hawk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 14 Jan 2003 08:43:12 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree, and Linus pointed out that obvious flaw in the interface when I
> sent it to him on Friday. I'll fixing that, and should up in his tree
> later today..
> 
> 	-pat
And more, could you possibly export 'kset_find_obj'? I thinks it is
useful for module too.
Yours truly,
Louis Zhuang
---------------
Fault Injection Test Harness Project
BK tree: http://fault-injection.bkbits.net/linux-2.5
Home Page: http://sf.net/projects/fault-injection

