Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVBFOt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVBFOt4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 09:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVBFOt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 09:49:56 -0500
Received: from canuck.infradead.org ([205.233.218.70]:42504 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261163AbVBFOtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 09:49:46 -0500
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Martins Krikis <mkrikis@yahoo.com>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <42062BFE.7070907@pobox.com>
References: <87651hdoiv.fsf@yahoo.com> <420582C6.7060407@pobox.com>
	 <1107682076.22680.58.camel@laptopd505.fenrus.org>
	 <58cb370e050206044513eb7f89@mail.gmail.com>  <42062BFE.7070907@pobox.com>
Content-Type: text/plain
Date: Sun, 06 Feb 2005 15:49:33 +0100
Message-Id: <1107701373.22680.115.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I consider it not a new feature, but a missing feature, since otherwise 
> user data cannot be accessed in the RAID setups.

the same is true for all new hardware drivers and hardware support
patches. And for new DRM (since new X may need it) and new .. and
new ... where is the line?

for me a deep maintenance mode is about keeping existing stuff working;
all new hw support and derivative hardware support (such as this) can be
pointed at the new stable series... which has been out for quite some
time now..

