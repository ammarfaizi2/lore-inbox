Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267450AbUBSBzo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 20:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267453AbUBSBzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 20:55:44 -0500
Received: from shower.ispgateway.de ([62.67.200.219]:30626 "HELO
	shower.ispgateway.de") by vger.kernel.org with SMTP id S267450AbUBSBzj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 20:55:39 -0500
Subject: Re: 2.6.3
From: Jochen Becker <jochen@linux.it4free.de>
To: B.Zolnierkiewicz@elka.pw.edu.pl, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, arvidjaar@mail.ru
In-Reply-To: <20040218174630.05253fd6.akpm@osdl.org>
References: <1077154272.3471.3.camel@jbdesktop>
	 <20040218174630.05253fd6.akpm@osdl.org>
Content-Type: text/plain
Organization: it4free.de
Message-Id: <1077155738.3471.7.camel@jbdesktop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 19 Feb 2004 02:55:39 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello recievers
andrew say to me that i have to send this to you.

Jochen

orig mail :

Am Do, den 19.02.2004 schrieb Andrew Morton um 02:46:
> Jochen Becker <jochen@linux.it4free.de> wrote:
> >
> > Hello Linus / Andrew
> > 
> > i have now compiled the kernel 2.6.3 and have problems
> > a) the time out for the ide driver sil serial ata is to long when their
> > is no harddisc installed. the kernel detects 2 times for 10 secounds
> 
> Please report this to
> 
> Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> and
> Jeff Garzik <jgarzik@pobox.com> and
> linux-kernel@vger.kernel.org
> 
> > b) what mean this message and how can i fix it could not find help by
> > google
> > devfs_mk_cdev: could not append to parent for bluetooth/rfcomm/1
> > -- cut 2 to 254
> > devfs_mk_cdev: could not append to parent for bluetooth/rfcomm/255
> 
> Please report this to
> 
> Andrey Borzenkov <arvidjaar@mail.ru> and
> linux-kernel@vger.kernel.org
> 
> > c) ISDN card AVM Fritz! 2.0 PCI (passiv avm card) how can i help to get
> > it work an in the kernel?
> 
> Try 2.6.3-mm1, it has lots of ISDN updates.  If that doesn't work, please
> report it to
> 
> Karsten Keil <kkeil@suse.de> and
> linux-kernel@vger.kernel.org
> 
> 

