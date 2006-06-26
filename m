Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWFZONF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWFZONF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWFZONE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:13:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7811 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750758AbWFZOND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:13:03 -0400
Subject: Re: finding pci_dev from scsi_device
From: Arjan van de Ven <arjan@infradead.org>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606261355.k5QDtcTm013419@wildsau.enemy.org>
References: <200606261355.k5QDtcTm013419@wildsau.enemy.org>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 16:13:01 +0200
Message-Id: <1151331181.3185.44.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 15:55 +0200, Herbert Rosmanith wrote:
> good day,
> 
> Could someone please tell me how to find the corresponding
> "struct pci_dev *" from a given "struct scsi_device *"?
> 
> I've been searching through structures/header files now for
> quite some time, but cannot find anything.

looking at my isa bus scsi controller... I'd say that that is a really
hard question that doesn't even always have an answer ;)

can you share with us what you want to do with this?

Greetings,
   Arjan van de Ven

