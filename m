Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUCHUFh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 15:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUCHUFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 15:05:37 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:14278 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261171AbUCHUFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 15:05:36 -0500
From: Christian Borntraeger <kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc2-mm1
Date: Mon, 8 Mar 2004 21:05:30 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
References: <20040307223221.0f2db02e.akpm@osdl.org>
In-Reply-To: <20040307223221.0f2db02e.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403082105.33788.kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc2/2
>.6.4-rc2-mm1/
>
>
> - Added Jens's patch which teaches the kernel to use DMA when reading
>   audio from IDE CDROM drives.  These devices tend to be flakey, and we
>   need lots of testing please.

Works great on my VIA KT133A with Toshiba SD-M1502. Grip cpu usage is 5 % 
instead of 90 %. 

cheers

Christian
