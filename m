Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbSKKKVM>; Mon, 11 Nov 2002 05:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266065AbSKKKVM>; Mon, 11 Nov 2002 05:21:12 -0500
Received: from pointblue.com.pl ([62.121.131.135]:62219 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id <S266038AbSKKKVL>;
	Mon, 11 Nov 2002 05:21:11 -0500
Subject: RE: random PID patch
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: linux-kernel-list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 11 Nov 2002 10:14:20 +0000
Message-Id: <1037009661.9807.11.camel@flat41>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I agree, though,  that it should not be implemented in the main-
> kernel. Still, it can be usefull.
Imho this should be just as an option to choose before kernel
compilation.
There are many patches already, that serves this feature (grsec).
This patch has already many other usefull features (proc restryctions
fe). That should already be in kernel, but as an option.

-- 
Greg Iaskievitch

