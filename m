Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268737AbTGaJEF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 05:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272427AbTGaJEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 05:04:05 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:19868 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S268737AbTGaJEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 05:04:02 -0400
Date: Thu, 31 Jul 2003 11:03:52 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Roman Zippel <zippel@linux-m68k.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] Re: [TRIVIAL] kill surplus menu in IDE Kconfig
Message-ID: <20030731090352.GH12849@louise.pinerecords.com>
References: <20030730055725.GG4279@louise.pinerecords.com> <Pine.SOL.4.30.0307301823210.8913-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0307301823210.8913-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > [B.Zolnierkiewicz@elka.pw.edu.pl]
> >
> > > - kill CONFIG_BLK_DEV_PDC202XX
> >
> > How do you mean?
> 
> It is not needed anymore.
> We have now CONFIG_BLK_DEV_PDC202XX_OLD and CONFIG_BLK_DEV_PDC202XX_NEW.

Oh, I was under the impression that this was already done.

> > > Does it sound sane?  If so I will later post patches for you review.
> >
> > Sounds good.  I can generate these patches if you're interested.
> 
> Patches are at:
> http://home.elka.pw.edu.pl/~bzolnier/ide-Kconfig/
> 
> They are against 2.6.0-test2.

Looks ok to me too.

-- 
Tomas Szepe <szepe@pinerecords.com>
