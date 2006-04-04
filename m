Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWDDPj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWDDPj0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 11:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWDDPj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 11:39:26 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:7861 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750715AbWDDPj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 11:39:26 -0400
Date: Tue, 4 Apr 2006 17:38:56 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Richard Purdie <richard@openedhand.com>
cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH RFC/testing] Upgrade the zlib_inflate library code to a
 recent version
In-Reply-To: <1144163888.6441.48.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0604041737440.14611@yvahk01.tjqt.qr>
References: <1144163888.6441.48.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Upgrade the zlib_inflate implementation in the kernel from a patched
>version 1.1.3 to a patched 1.2.3. 
>
>The code in the kernel is about seven years old and I noticed that the
>external zlib library's inflate performance was significantly faster
>(~50%) than the code in the kernel on ARM (and faster again on x86_32).
>
Any plans to move to something newer, e.g. bzip2 or LZMA?


Jan Engelhardt
-- 
