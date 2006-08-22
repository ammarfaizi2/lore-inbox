Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWHVAyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWHVAyz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 20:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWHVAyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 20:54:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37253 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750999AbWHVAyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 20:54:54 -0400
Subject: Re: [PATCH] [LIBATA] [mm] change path to libata in libata.tmpl
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Henne <henne@nachtwindheim.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44EA3E32.7060607@nachtwindheim.de>
References: <44EA3E32.7060607@nachtwindheim.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Aug 2006 02:15:55 +0100
Message-Id: <1156209355.24086.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-22 am 01:13 +0200, ysgrifennodd Henne:
> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> Since libata moved from /drivers/scsi to /drivers/ata this template is broken.
> This patch fixes it.
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

Acked-by: Alan Cox <alan@redhat.com>

