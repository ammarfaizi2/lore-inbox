Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUFWM7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUFWM7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUFWM7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:59:42 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:1954 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265402AbUFWM7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:59:02 -0400
Date: Wed, 23 Jun 2004 22:00:18 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
In-reply-to: <F1C4591B482AC7indou.takao@soft.fujitsu.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nobuhiro Tachino <ntachino@redhat.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@muc.de>
Message-id: <F3C4592208A2F9indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <F1C4591B482AC7indou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004 21:11:58 +0900, Takao Indoh wrote:

>>does this patch stabilize diskdump?
>
>No. There is one thing I need correct. I need replace proc interface
>with sysfs, as Christoph and Arjan commented.
>After fix this, I'll release stable version 1.0.

Sorry, I misread. Yes, diskdump is stable with your patch. Thanks.

Best Regards,
Takao Indoh
