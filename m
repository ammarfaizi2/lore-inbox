Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265978AbSLSSjx>; Thu, 19 Dec 2002 13:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265960AbSLSSjw>; Thu, 19 Dec 2002 13:39:52 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63467
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265939AbSLSSjt>; Thu, 19 Dec 2002 13:39:49 -0500
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davem@redhat.com
In-Reply-To: <1040313919.2650.31.camel@localhost>
References: <1040225146.1873.21.camel@localhost> 
	<1040313919.2650.31.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Dec 2002 19:28:35 +0000
Message-Id: <1040326115.28973.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 16:05, Max Krasnyansky wrote:
> Hmm, no replies. Nobody is interested in this or what ?
> I want to get this fixed otherwise I can't fix Bluetooth module
> refcounting. 

Looks good to me, but its christmas so I wouldnt expect much to happen
till the new year

