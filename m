Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268315AbUIQDA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268315AbUIQDA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 23:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUIQDA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 23:00:27 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:32458 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S268315AbUIQDAZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 23:00:25 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1
Date: Fri, 17 Sep 2004 00:00:07 -0300
User-Agent: KMail/1.7
References: <20040916024020.0c88586d.akpm@osdl.org>
In-Reply-To: <20040916024020.0c88586d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409170000.07215.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6
>.9-rc2-mm1/

I mentioned before that this kernel was giving me problems with nvidia (fixed 
thanks to "jedi/sector one") and vmware. Now I'm at home so I booted 
2.6.9-rc2-mm1 and this is what vmware is saying:

    "Could not mmap 139264 bytes of memory from file offset 0 at (nil):
    Operation not permitted. Failed to allocate shared memory."

Anyone knows what's going on here?

Many thanks in advance,
Norberto
