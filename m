Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTHUABP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 20:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbTHUABP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 20:01:15 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:58266 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262344AbTHUABO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 20:01:14 -0400
Subject: Re: DVD ROM on 2.6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bill davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <bi0db7$err$1@gatekeeper.tmr.com>
References: <200308192009.11298.admin@kentonet.net>
	 <bi0db7$err$1@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061423984.1199.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 21 Aug 2003 00:59:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-20 at 19:06, bill davidsen wrote:
> If iso9660 looks enough like UDF to confuse the f/s typing logic, would
> the problem go away if the iso9660 were checked first? It seems iso9660
> can be mistaken for UDF, is the converse true?
> 
> In any case it can be set explicitly.

Disks can be mastered with both

