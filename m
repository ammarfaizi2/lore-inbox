Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965331AbWAHVwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965331AbWAHVwV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 16:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965343AbWAHVwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 16:52:21 -0500
Received: from mail07.powweb.com ([66.152.97.40]:8708 "EHLO mail07.powweb.com")
	by vger.kernel.org with ESMTP id S965331AbWAHVwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 16:52:20 -0500
From: Carlos Manuel Duclos Vergara <carlos@embedded.cl>
To: kernel-janitors@lists.osdl.org
Subject: Re: MODULE_VERSION useless? (was Re: [KJ] adding missing MODULE_* stuffs)
Date: Sun, 8 Jan 2006 18:55:16 -0300
User-Agent: KMail/1.8.2
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <kees@outflux.net>,
       linux-kernel@vger.kernel.org
References: <20051230000400.GS18040@outflux.net> <20060108204549.GB5864@mipter.zuzino.mipt.ru>
In-Reply-To: <20060108204549.GB5864@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601081855.17723.carlos@embedded.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I have two ideas about what to do with MODULE_VERSION:
1.- Defining MODULE_VERSION = KERNEL_VERSION
2.- Schedule it for removal in one or two more versions, and automagically use 
the KERNEL_VERSION as module's version.

Any comments?

-- 
Carlos Manuel Duclos Vergara
http://www.toolchains.com/personal/blog
