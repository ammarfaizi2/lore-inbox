Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbTIHMee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 08:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTIHMee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 08:34:34 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:24194 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262249AbTIHMed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 08:34:33 -0400
Subject: Re: possible GPL violation by Sigma Designs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Torgeir Veimo <torgeir@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1062985742.3771.16.camel@africa.netenviron.com>
References: <1062985742.3771.16.camel@africa.netenviron.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063024404.21084.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Mon, 08 Sep 2003 13:33:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-08 at 02:49, Torgeir Veimo wrote:
> The Sigma Designs EM8500 is apparently a combined mpeg4 decoder and RISC
> processor. I'd assume that they would be required to release source code
> on request for their kernel, even if the code is executed on the EM8500
> directly, as opposed being controller by a kernel driver running on a
> separate processor?

If the EM8500 is running a linux kernel then they need to state that
provide the offer of source code or provide the source and obey the GPL.
I'd suspect if it runs Linux on the 8500 it runs Linux + apps and the
interesting DVD stuff is the apps not the kernel however 8)


