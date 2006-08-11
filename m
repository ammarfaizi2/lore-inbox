Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWHKTvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWHKTvI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWHKTvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:51:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63385 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964772AbWHKTvH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:51:07 -0400
Subject: Re: [PATCH resend] via82cxxx: Add VIA VT8237A southbridge ID
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       jeff@garzik.org, bzolnier@gmail.com
In-Reply-To: <20060811193346.E2D0C8E75CD@zog.reactivated.net>
References: <20060811193346.E2D0C8E75CD@zog.reactivated.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 11 Aug 2006 21:10:49 +0100
Message-Id: <1155327049.24077.121.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-11 am 20:33 +0100, ysgrifennodd Daniel Drake:
> Some motherboards based on the KT890 chipset include this southbridge. Adding
> it allows the via82cxxx IDE driver to be used on these systems.

Already in -mm.

Alan

