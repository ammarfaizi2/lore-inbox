Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271270AbTHCVIY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271284AbTHCVIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:08:23 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:49305 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271270AbTHCVIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:08:19 -0400
Subject: Re: [PATCH][2.6.0-test2] fix ata_probe driver autoloading (another
	module failing to autoload - ide-cd)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: David Walser <luigiwalser@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Olivier Thauvin <olivier.thauvin@aerov.jussieu.fr>
In-Reply-To: <200308031533.37745.arvidjaar@mail.ru>
References: <20030802185054.35243.qmail@web14006.mail.yahoo.com>
	 <200308031533.37745.arvidjaar@mail.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059944661.31901.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Aug 2003 22:04:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-03 at 12:33, Andrey Borzenkov wrote:
> Apply this patch :). Apparently drive->driver is never NULL now but defaults 
> to default driver.

Looks good to me

