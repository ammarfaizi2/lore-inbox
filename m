Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbTFULZD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 07:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbTFULZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 07:25:03 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6599
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265136AbTFULZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 07:25:01 -0400
Subject: Re: xircom card bus with 2.4.20 link trouble
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mike Dresser <mdresser_l@windsormachine.com>
Cc: Arnaud Ligot <spyroux@freegates.be>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0306201147220.15589-100000@router.windsormachine.com>
References: <Pine.LNX.4.33.0306201147220.15589-100000@router.windsormachine.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056195410.25975.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jun 2003 12:36:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-20 at 16:49, Mike Dresser wrote:
> Now if only DMA mode would work on the Opti 621 chipset inside this
> Omnibook 5500/5700 hybrid laptop :)  Then it wouldn't take 38 minutes to
> compile.  

It should do - drivers/ide/pci/opti621.c


