Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTEDNEN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 09:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbTEDNEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 09:04:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31449 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263610AbTEDNEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 09:04:12 -0400
Date: Sun, 04 May 2003 05:09:32 -0700 (PDT)
Message-Id: <20030504.050932.115911576.davem@redhat.com>
To: romieu@fr.zoreil.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: DECNET in latest BK
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030503203908.A5915@electric-eye.fr.zoreil.com>
References: <20030503175913.GA13595@work.bitmover.com>
	<1051987091.14504.9.camel@rth.ninka.net>
	<20030503203908.A5915@electric-eye.fr.zoreil.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Francois Romieu <romieu@fr.zoreil.com>
   Date: Sat, 3 May 2003 20:39:08 +0200

   David S. Miller <davem@redhat.com> :
   [...]
   > Turn off CONFIG_DECNET_ROUTE_FWMARK, aparently even the maintainer
   > doesn't even enable this option :-)
   
   Does the attached patch make sense ?

Looks good, applied.

Thanks.
