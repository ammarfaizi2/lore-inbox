Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbTFQWOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbTFQWOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:14:10 -0400
Received: from aneto.able.es ([212.97.163.22]:23237 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264959AbTFQWN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:13:59 -0400
Date: Wed, 18 Jun 2003 00:27:50 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCHES] 2.4.x net driver updates
Message-ID: <20030617222750.GE13990@werewolf.able.es>
References: <20030612194926.GA7653@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030612194926.GA7653@gtf.org>; from jgarzik@pobox.com on Thu, Jun 12, 2003 at 21:49:26 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.12, Jeff Garzik wrote:
> 
> BK users may issue a
> 
> 	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.4
> 
> Others may download the patch from
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.21-rc8-netdrvr2.patch.bz2
> 

Any info about the RX_POLLING (NAPI) option for e1000 ?
What is that for ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-1mdk))
