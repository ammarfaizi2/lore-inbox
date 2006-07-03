Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWGCIID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWGCIID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 04:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWGCIID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 04:08:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20159 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750795AbWGCIIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 04:08:01 -0400
Subject: Re: [PATCH 2.6.17.1 2/2] dllink driver: porting v1.19 to linux
	2.6.17
From: Arjan van de Ven <arjan@infradead.org>
To: Hayim Shaul <hayim@iportent.com>
Cc: edward_peng@dlink.com.tw, linux-kernel@vger.kernel.org
In-Reply-To: <1151913992.2859.21.camel@localhost.localdomain>
References: <1151913992.2859.21.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 10:07:46 +0200
Message-Id: <1151914066.3108.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 11:06 +0300, Hayim Shaul wrote:
> Description:
> For DLink Fiber NIC, Linux 2.4.22 ships with driver version 1.19,
> whereas, Linux 2.6.x ship with driver version 1.17.
> 
> The following patch upgrades the 2.6.x driver to include changes (and
> bug 
> +    1.19a	2006/07/01	made compile on kernel 2.6.15.
> (hayim@iportent.com)
>  

Hi,

your email program has line-wrapped the patches, which means they cannot
be applied with the patch command.
I see that you are using evolution; with evolution you can disable this
wrapping for a part of the email by clicking on the "Normal" thing just
above the text entry window, and set it to "Preformat".

Since you still have the patches correct on your machine, could you
resend them in "Preformat" mode? That makes it a lot easier for people
to do anything with them

Greetings,
   Arjan van de Ven

