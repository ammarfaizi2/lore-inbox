Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbTIIQLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 12:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264216AbTIIQLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 12:11:20 -0400
Received: from [63.205.85.133] ([63.205.85.133]:38346 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S264201AbTIIQLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 12:11:18 -0400
Date: Tue, 9 Sep 2003 09:18:04 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test5: CONFIG_ATM_BR2684 build fails
Message-ID: <20030909161804.GA39249@gaz.sfgoth.com>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org> <3F5DC73F.69916959@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5DC73F.69916959@eyal.emu.id.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eyal Lebedinsky wrote:
> net/atm/br2684.c: In function `br2684_seq_show':
> net/atm/br2684.c:735: `pos' undeclared (first use in this function)

There is a patch posted elsewhere for this already, I believe it's in
davem's queue:
  http://sourceforge.net/mailarchive/message.php?msg_id=5990455

-Mitch
