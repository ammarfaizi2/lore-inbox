Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWCBM12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWCBM12 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 07:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWCBM11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 07:27:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36037 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751388AbWCBM11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 07:27:27 -0500
Subject: Re: [PATCH] pcmcia: add another ide-cs CF card id
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Dominik Brodowski <linux@dominikbrodowski.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4406E1C7.7020908@pobox.com>
References: <200603012259.k21MxBXC013582@hera.kernel.org>
	 <44062FF1.4010108@pobox.com> <20060302075004.GA17789@isilmar.linta.de>
	 <4406D44A.4020101@pobox.com>
	 <1141299117.3206.37.camel@laptopd505.fenrus.org>
	 <20060302114220.GH4329@suse.de>
	 <1141301225.3206.50.camel@laptopd505.fenrus.org>
	 <4406E1C7.7020908@pobox.com>
Content-Type: text/plain
Date: Thu, 02 Mar 2006 13:27:22 +0100
Message-Id: <1141302442.3206.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> About a quarter of the time when non-netdev maintainers add IDs, through 
> the magic of merges, we've wound up with duplicate IDs in the driver. 
> I've snipped several duplicate IDs from tulip and other net drivers over 
> the years.

sure. But in this case Dominik IS the maintainer

> Further, in the past Brodo has _already_ been asked to CC relevant 
> maintainers and lists -- or at least LKML -- with his patches.

he mailed the relevant list, linux-pcmcia ... whats wrong?

Maybe you are right about the pattern, but this time it's not that...
maybe you should apologize and flame Dominik the next time instead ;)

