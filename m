Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUIGSCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUIGSCN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUIGSCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:02:13 -0400
Received: from the-village.bc.nu ([81.2.110.252]:26277 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264265AbUIGSCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:02:12 -0400
Subject: Re: [PATCH] remove wake_up_all_sync
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040907151154.GB9577@lst.de>
References: <20040907151154.GB9577@lst.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094576397.9607.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 17:59:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-07 at 16:11, Christoph Hellwig wrote:
> no user in sight

That doesn't mean its not a logical part of the API, and since its a
define one which has zero cost in being present. I think you are taking
things beyond the ridiculous in this area.

Alan

