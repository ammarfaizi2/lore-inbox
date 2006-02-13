Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751654AbWBMI57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbWBMI57 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWBMI57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:57:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36310 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751095AbWBMI56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:57:58 -0500
Subject: Re: Linux 2.6.16-rc3
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Brown, Len" <len.brown@intel.com>, davem@davemloft.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, axboe@suse.de,
       James.Bottomley@steeleye.com, greg@kroah.com,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       luming.yu@intel.com, lk@bencastricum.nl, sanjoy@mrao.cam.ac.uk,
       helgehaf@aitel.hist.no, fluido@fluido.as, gbruchhaeuser@gmx.de,
       Nicolas.Mailhot@LaPoste.net, perex@suse.cz, tiwai@suse.de,
       patrizio.bassi@gmail.com, bni.swe@gmail.com, arvidjaar@mail.ru,
       p_christ@hol.gr, ghrt@dial.kappa.ro, jinhong.hu@gmail.com,
       andrew.vasquez@qlogic.com, linux-scsi@vger.kernel.org, bcrl@kvack.org
In-Reply-To: <20060213001240.05e57d42.akpm@osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B30060BD1D9@hdsmsx401.amr.corp.intel.com>
	 <20060213001240.05e57d42.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 09:57:48 +0100
Message-Id: <1139821068.2997.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 00:12 -0800, Andrew Morton wrote:
> "Brown, Len" <len.brown@intel.com> wrote:
> >
> > My point is that it that on the grand scale of bugs serious enough
> >  to have an effect on the course of 2.6.16, this one doesn't qualify
> >  unless the same issue is seen on other systems.
> 
> I think we can assume that it will be seen there.  2.6.16 is going into
> distros and will have more exposure than 2.6.15, 

2.6.15 went into distros as well, such as Fedora Core 4 ;)


