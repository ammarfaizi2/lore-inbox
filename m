Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266681AbUGVDCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266681AbUGVDCj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 23:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266683AbUGVDCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 23:02:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:9615 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266681AbUGVDCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 23:02:38 -0400
Date: Wed, 21 Jul 2004 23:00:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
Message-Id: <20040721230044.20fdc5ec.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote:
>
> This patch deletes cryptoloop,

OK - if nobody complains convincingly we'll drop cryptoloop out of 2.6.9.

> which is buggy, unmaintained, and
> reportedly has mutliple security weaknesses.

Doesn't dm-crypt have the same security weaknesses?

