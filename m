Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266108AbSKTNZS>; Wed, 20 Nov 2002 08:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbSKTNZS>; Wed, 20 Nov 2002 08:25:18 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:9345 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266108AbSKTNZR>; Wed, 20 Nov 2002 08:25:17 -0500
Subject: Re: Fw: Troubles with Sony PCG-C1MHP (crusoe based and ALIM 1533
	drivers)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021120094121.7b6c7d34.Manuel.Serrano@sophia.inria.fr>
References: <20021120094121.7b6c7d34.Manuel.Serrano@sophia.inria.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 14:00:51 +0000
Message-Id: <1037800851.3241.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 08:44, Manuel Serrano wrote:
> For information, 
> 
> I have tried the new linux-2.4.20-rc2-ac1 version and it shows the
> same problems as 2.4.20-rc1-ac4. That is, the kernel does not boot

Can you look up the EIP and call trace values in system.map or feed the
oops data to ksymoops >

