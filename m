Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267590AbTGONGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 09:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267647AbTGONGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 09:06:23 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:61381
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S267590AbTGONGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 09:06:21 -0400
Subject: Re: PROBLEM: Module maestro3 fails to load on Dell Latitude C510
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dbell@perfectorder.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200307150852.20854.dbell@perfectorder.com>
References: <200307150852.20854.dbell@perfectorder.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058275117.3845.37.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jul 2003 14:18:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-15 at 13:52, Doug Bell wrote:
> 
> # insmod maestro3
> Using /lib/modules/2.4.21-0.13mdk/kernel/drivers/sound/maestro3.o.gz
> /lib/modules/2.4.21-0.13mdk/kernel/drivers/sound/maestro3.o.gz: unresolved 
> symbol ac97_probe_codec_R84601c2b

Not an error - use "modprobe"

