Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTD2SCZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbTD2SCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 14:02:25 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39060
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262119AbTD2SCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 14:02:24 -0400
Subject: RE: LSI MegaRAID ATA driver (COMPAQ Proliant DL-320 G2)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Mukker, Atul" <atulm@lsil.com>
Cc: prequejo@dbs.es, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "'Martin_List-Petersen@Dell.com'" <Martin_List-Petersen@Dell.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570185F15D@EXA-ATLANTA.se.lsil.com>
References: <0E3FA95632D6D047BA649F95DAB60E570185F15D@EXA-ATLANTA.se.lsil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051636554.18199.46.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Apr 2003 18:15:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-29 at 17:27, Mukker, Atul wrote:
>  > > Well... Now, I need to upgrade and rebuild the kernel (2.4.18 
> > > to 2.4.20)
> > > but, I haven't got the source code of the LSI MegaRAID ATA 
> > controller.
> > > 
> That's right, the source for this software stack is not released under GPL.
> We do release the RPM packages to update driver. This is true for the stock
> kernels only. It is not possible to use the RPM for all (or individually
> compiled) kernels

Or last time I checked you can load the CMD IDE driver just use the
standard kernel software raid instead of the AMI one. 


