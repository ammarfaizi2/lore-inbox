Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267511AbSLFCJJ>; Thu, 5 Dec 2002 21:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267512AbSLFCJJ>; Thu, 5 Dec 2002 21:09:09 -0500
Received: from smtp.comcast.net ([24.153.64.2]:45102 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S267511AbSLFCJI>;
	Thu, 5 Dec 2002 21:09:08 -0500
Date: Thu, 05 Dec 2002 21:16:38 -0500
From: Tom Vier <tmv@comcast.net>
Subject: 2.4.20 smp on alpha won't boot
To: linux-kernel@vger.kernel.org
Reply-to: Tom Vier <tmv@comcast.net>
Message-id: <20021206021638.GA357@yzero>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

my dual 667mhz up2000+ will not boot 2.4.20 when compiled w/ smp support. it
dies, killing the idle task after trying to access virt addr 0, just after
the slab info is printed. 

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA
