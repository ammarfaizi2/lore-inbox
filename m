Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWEPQhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWEPQhl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWEPQhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:37:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:21924 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932116AbWEPQhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:37:40 -0400
Date: Tue, 16 May 2006 18:37:26 +0200
From: Olaf Hering <olh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Ihno Krumreich <ihno@suse.de>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: 2.6.17-rc4-mm1: please drop add-raw-driver-kconfig-entry-for-s390.patch
Message-ID: <20060516163726.GA13798@suse.de>
References: <20060515005637.00b54560.akpm@osdl.org> <20060516161228.GF5677@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060516161228.GF5677@stusta.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, May 16, Adrian Bunk wrote:

> This driver is declared obsolete since more than two years, and while 
> it's worth a discussion how long to keep it for legacy users, merging a 
> patch offering an obsolete driver for even more users is silly.

If it is so deprecated, just drop it for 2.6.17. I mean, no major distro
that counts will be based on 2.6.17, so noone will miss it from now on.
nails with heads and stuff...
