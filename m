Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030472AbWBNFbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbWBNFbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030469AbWBNFbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:31:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41409 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030465AbWBNFbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:31:08 -0500
Subject: Re: Linux 2.6.16-rc3
From: Arjan van de Ven <arjan@infradead.org>
To: Michal Jaegermann <michal@harddata.com>
Cc: Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       davem@davemloft.net, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       axboe@suse.de, James.Bottomley@steeleye.com, greg@kroah.com,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       luming.yu@intel.com, lk@bencastricum.nl, sanjoy@mrao.cam.ac.uk,
       helgehaf@aitel.hist.no, fluido@fluido.as, gbruchhaeuser@gmx.de,
       Nicolas.Mailhot@LaPoste.net, perex@suse.cz, tiwai@suse.de,
       patrizio.bassi@gmail.com, bni.swe@gmail.com, arvidjaar@mail.ru,
       p_christ@hol.gr, ghrt@dial.kappa.ro, jinhong.hu@gmail.com,
       andrew.vasquez@qlogic.com, linux-scsi@vger.kernel.org, bcrl@kvack.org
In-Reply-To: <20060214030821.GA23031@mail.harddata.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30060BD1D9@hdsmsx401.amr.corp.intel.com>
	 <20060213001240.05e57d42.akpm@osdl.org>
	 <1139821068.2997.22.camel@laptopd505.fenrus.org>
	 <20060214030821.GA23031@mail.harddata.com>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 06:31:01 +0100
Message-Id: <1139895061.4117.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 20:08 -0700, Michal Jaegermann wrote:
> On Mon, Feb 13, 2006 at 09:57:48AM +0100, Arjan van de Ven wrote:
> > On Mon, 2006-02-13 at 00:12 -0800, Andrew Morton wrote:
> > > 
> > > I think we can assume that it will be seen there.  2.6.16 is going into
> > > distros and will have more exposure than 2.6.15, 
> > 
> > 2.6.15 went into distros as well, such as Fedora Core 4 ;)
> 
> And promptly broke laptop suspension.  See, for example:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=180998


fedora core 4 never really supported suspend in the first place tho..


