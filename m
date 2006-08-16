Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWHPQdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWHPQdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWHPQdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:33:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44981 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932105AbWHPQdI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:33:08 -0400
Subject: Re: [RFC][PATCH 4/7] UBC: syscalls (user interface)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E33C3F.3010509@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C3F.3010509@sw.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 17:52:51 +0100
Message-Id: <1155747171.24077.374.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-16 am 19:39 +0400, ysgrifennodd Kirill Korotaev:
> Add the following system calls for UB management:
>   1. sys_getluid    - get current UB id
>   2. sys_setluid    - changes exec_ and fork_ UBs on current
>   3. sys_setublimit - set limits for resources consumtions
> 
> Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
> Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Acked-by: Alan Cox <alan@redhat.com>

