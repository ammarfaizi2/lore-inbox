Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267401AbSLSAOm>; Wed, 18 Dec 2002 19:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267402AbSLSAOm>; Wed, 18 Dec 2002 19:14:42 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:65001
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267401AbSLSAOl>; Wed, 18 Dec 2002 19:14:41 -0500
Subject: Re: 2.5.52: PDC20268 failure
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frank van de Pol <fvdpol@home.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021218232901.GA20290@idefix.fvdpol.home.nl>
References: <20021218232901.GA20290@idefix.fvdpol.home.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Dec 2002 01:03:16 +0000
Message-Id: <1040259796.26906.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 23:28, Frank van de Pol wrote:
> 
> the 2.5 series of kernels (since early ide changes) fails on my machine when
> configuring the harddisks.

Can you tell me if 2.4.21-pre does - that has the IDE changes without
the other stuff so is a good test of which bit is involved

Also try 2.5.52 with ACPI disabled

