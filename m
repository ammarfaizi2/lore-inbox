Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268075AbUHKOa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268075AbUHKOa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 10:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268072AbUHKOas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 10:30:48 -0400
Received: from dsl092-149-163.wdc2.dsl.speakeasy.net ([66.92.149.163]:44818
	"EHLO localhost") by vger.kernel.org with ESMTP id S268071AbUHKOaq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 10:30:46 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Brian Beattie <beattie@beattie-home.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jbglaw@lug-owl.de, skraw@ithnet.com, alan@lxorguk.ukuu.org.uk,
       axboe@suse.de, diablod3@gmail.com, dwmw2@infradead.org,
       eric@lammerts.org, james.bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200408102133.i7ALXAOf014580@burner.fokus.fraunhofer.de>
References: <200408102133.i7ALXAOf014580@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Message-Id: <1092234630.19232.2.camel@kokopelli>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 11 Aug 2004 10:30:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 17:33, Joerg Schilling wrote:

> 
> If you like to write DVDs, you of course need cdrecord-ProDVD
> 
> ftp://ftp.berlios.de/pub/cdrecord/ProDVD/
> 
> I am trying my best so support any DVD writer since 1997

Does this product properly support OS prefered naming?  i.e.
/dev/hd?|/dev/sg? on Linux, X: on Windows?

-- 
Brian Beattie   LFS12947 | "Honor isn't about making the right choices.
beattie@beattie-home.net | It's about dealing with the consequences."
www.beattie-home.net     | -- Midori Koto


