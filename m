Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbTIOWfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 18:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbTIOWfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 18:35:45 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:37539 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261668AbTIOWfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 18:35:40 -0400
Subject: Re: 2.4.23-pre4-pac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: edouardino@ifrance.com
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <wazza.87znh6t891.fsf@message.id>
References: <Pine.LNX.4.56.0309151411010.14486@dot.kde.org>
	 <wazza.87znh6t891.fsf@message.id>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063665253.8257.27.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Mon, 15 Sep 2003 23:34:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-15 at 15:51, edouardino@ifrance.com wrote:
> Hi,
> 
> Could you send me the Device Mapper patch you used ?
> Or could you make -pac available as splitted patches too ?
> I fact I'd like to use a recent dm.

Its the bits in drivers/md and include/linux/dm* - easy to split out.
It is quite old. The Sistina guys have been promising me an update for
some time but I guess 2.6 is far more important

