Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263553AbTDNQrj (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263554AbTDNQrj (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:47:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36794
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263553AbTDNQri (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 12:47:38 -0400
Subject: Re: P4-CPU/NoBoot
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0304140954420.25232@chaos>
References: <Pine.LNX.4.53.0304140954420.25232@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050336068.25353.74.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Apr 2003 17:01:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-14 at 14:55, Richard B. Johnson wrote:
> I tried to install RH 7.0 on a new box this
> week-end:
> 
> 	Motherboard MSI 648 Max
> 	CPU Intel P4 2.8 GHz
> 	Memory 1024 MB PC-333 DDR

7.0 is an odd thing to install but ought to have
worked. 7.0 doesn't handle PIV feature stuff and
also doesn't support SMP or hyperthreaded PIV
(you'll get random segfaults). Intel provided fixes
for that specific kernel bug in later kernels

