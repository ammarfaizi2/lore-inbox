Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWFZOx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWFZOx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWFZOx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:53:56 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:18590 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S932101AbWFZOxz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:53:55 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606261447.k5QElseJ013480@wildsau.enemy.org>
Subject: Re: finding pci_dev from scsi_device
In-Reply-To: <1151332900.3185.49.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Date: Mon, 26 Jun 2006 16:47:54 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> also.. you could just put your code into the remove hook... :)

oh by the way, that's the reason why I need to find the pci-pointer myself.
in our environment, the remove hook is never called.

kind regards,
h.rosmanith
