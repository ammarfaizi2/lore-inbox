Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268413AbUIGSs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268413AbUIGSs2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268505AbUIGSiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:38:21 -0400
Received: from the-village.bc.nu ([81.2.110.252]:39333 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268413AbUIGSba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:31:30 -0400
Subject: Re: [PATCH] unexport get_wchan
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040907181130.GA12595@lst.de>
References: <20040907144539.GA8808@lst.de>
	 <1094576868.9607.7.camel@localhost.localdomain>
	 <20040907181130.GA12595@lst.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094578157.9607.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 18:29:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-07 at 19:11, Christoph Hellwig wrote:
> Which debuging tool?  Both kdb and xmon don't use it.

You broke my kgdb 8) 
