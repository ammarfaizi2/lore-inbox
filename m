Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbUCARgL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 12:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUCARgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 12:36:11 -0500
Received: from devil.servak.biz ([209.124.81.2]:39128 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S261377AbUCARgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 12:36:08 -0500
Subject: Re: 2.6.4-rc1-mm1: multiple definitions of `debug'
From: Torrey Hoffman <thoffman@arnor.net>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       linux-usb-devel list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <20040301011012.GI13764@fs.tum.de>
References: <20040229140617.64645e80.akpm@osdl.org>
	 <20040301011012.GI13764@fs.tum.de>
Content-Type: text/plain
Message-Id: <1078163384.25556.16.camel@moria.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 01 Mar 2004 09:49:44 -0800
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-29 at 17:10, Adrian Bunk wrote:

> The new drivers/usb/input/ati_remote.c driver thinks "debug" would be a
> good name for a global variable...

(blush) Mea culpa. Sorry!

> 
> cu
> Adrian
-- 
Torrey Hoffman <thoffman@arnor.net>

