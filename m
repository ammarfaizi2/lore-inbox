Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266982AbSL3Oce>; Mon, 30 Dec 2002 09:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbSL3Ocd>; Mon, 30 Dec 2002 09:32:33 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5505
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266982AbSL3Ocd>; Mon, 30 Dec 2002 09:32:33 -0500
Subject: Re: Speed of Ethernet Interface in linux-kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: narayana rao <narayank@intotoinc.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.0.20021230195141.009f6da0@172.16.1.10>
References: <5.1.0.14.0.20021230195141.009f6da0@172.16.1.10>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 15:22:32 +0000
Message-Id: <1041261752.13684.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 14:22, narayana rao wrote:
> Hi All,
> 
>      I am Implementing MIB-II( rfc-1213) on Linux. All these API's are kept 
> under kernel. my questions is how can I get speed of the Ethernet 

Why not do it in user space like everyone else does ? You get the speed
on newer interfaces using the ethtool interfaces


