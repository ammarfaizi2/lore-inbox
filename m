Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263228AbUEWSMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUEWSMo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 14:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbUEWSMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 14:12:44 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:59089 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S263228AbUEWSMn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 14:12:43 -0400
Subject: Re: Sluggish performances with FreeBSD
From: Laurent Goujon <laurent.goujon@online.fr>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Rudo Thomas <rudo@matfyz.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20040523002520.B2655@electric-eye.fr.zoreil.com>
References: <1085080302.7764.20.camel@caribou.no-ip.org>
	 <20040520193406.GA16184@ss1000.ms.mff.cuni.cz>
	 <1085083195.4240.4.camel@caribou.no-ip.org>
	 <20040520232957.A2172@electric-eye.fr.zoreil.com>
	 <1085091424.4238.13.camel@caribou.no-ip.org>
	 <20040521003616.D2172@electric-eye.fr.zoreil.com>
	 <1085093395.4238.22.camel@caribou.no-ip.org>
	 <20040521205503.A18763@electric-eye.fr.zoreil.com>
	 <1085185065.4277.0.camel@caribou.no-ip.org>
	 <20040523002520.B2655@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1085335969.4433.10.camel@caribou.no-ip.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7-3mdk 
Date: Sun, 23 May 2004 20:12:50 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le dim, 23/05/2004 à 00:25 +0200, Francois Romieu a écrit :
> Laurent Goujon <laurent.goujon@online.fr> :
> 
> Do you run the test where data flows from the server to the laptop from X ?
> 
> You said you reach 4Mb/s from Internet to your laptop. I guess this is
> on a distinct LAN than the one where your freebsd server stands, right ?

My FreeBSD server acts as a gateway. On one side, there is my laptop,
and on the other side, I've a DSL access with a download throughput
which reach usually the 4-5Mb/s

When I download with my laptop from Internet, the flow pass thru my
gateway and I can reach the limit (with a good ftp server...). But when
I directly download from my own server, it's slower than to download
from Internet...

Laurent


