Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbWJKPHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbWJKPHG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 11:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbWJKPHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 11:07:06 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:20624 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S965227AbWJKPHF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 11:07:05 -0400
Message-ID: <452D0894.5080805@drzeus.cx>
Date: Wed, 11 Oct 2006 17:07:00 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Matthew Wilcox <matthew@wil.cx>, Amol Lad <amol@verismonetworks.com>,
       kernel Janitors <kernel-janitors@lists.osdl.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: most users of msleep_interruptible are broken
References: <1160570743.19143.307.camel@amol.verismonetworks.com>	 <1160571491.3000.372.camel@laptopd505.fenrus.org>	 <20061011141651.GD27388@parisc-linux.org>  <452CFD98.6010808@drzeus.cx> <1160578415.3000.381.camel@laptopd505.fenrus.org>
In-Reply-To: <1160578415.3000.381.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>
> if you want that don't use the _interruptible variant. It's that simple.
>
>   

Patches welcome ;)

I believe noone has fixed the if-condition yet as well...

Rgds
Pierre

