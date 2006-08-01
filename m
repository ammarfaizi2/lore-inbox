Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWHAOl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWHAOl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWHAOl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:41:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12940 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751315AbWHAOlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:41:55 -0400
Subject: Re: [PATCH][Doc] Fix kerneldoc comments in kernel/timer.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rdunlap@xenotime.net>
In-Reply-To: <200608011631.40189.eike-kernel@sf-tec.de>
References: <200608011631.40189.eike-kernel@sf-tec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Aug 2006 16:00:46 +0100
Message-Id: <1154444446.15540.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-01 am 16:31 +0200, ysgrifennodd Rolf Eike Beer:
> Some of the kerneldoc comments in this file are ignored since the lead-in is
> malformed, using either "/*" or "/***" instead of "/**".
> 
> Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

Acked-by: Alan Cox <alan@redhat.com>

