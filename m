Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUFQOw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUFQOw2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 10:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266518AbUFQOw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 10:52:28 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:16094 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266519AbUFQOw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 10:52:27 -0400
Date: Thu, 17 Jun 2004 23:53:42 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
In-reply-to: <40D1AE7F.8080902@redhat.com>
To: Nobuhiro Tachino <ntachino@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@muc.de>
Message-id: <CEC4547AE1EB3Dindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <40D1AE7F.8080902@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004 10:45:19 -0400, Nobuhiro Tachino wrote:

>I think you should save original values to somewhere else, so you can
>refer these values from vmcore if you want.

Yes, I should. It is necessary if kernel crashed because of timer
problem. Thanks!

Best Regards,
Takao Indoh

