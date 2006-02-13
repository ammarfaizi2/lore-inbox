Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWBMIQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWBMIQO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWBMIQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:16:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48306 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751229AbWBMIQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:16:12 -0500
Date: Mon, 13 Feb 2006 00:12:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Brown, Len" <len.brown@intel.com>
Cc: davem@davemloft.net, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       axboe@suse.de, James.Bottomley@steeleye.com, greg@kroah.com,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       luming.yu@intel.com, lk@bencastricum.nl, sanjoy@mrao.cam.ac.uk,
       helgehaf@aitel.hist.no, fluido@fluido.as, gbruchhaeuser@gmx.de,
       Nicolas.Mailhot@LaPoste.net, perex@suse.cz, tiwai@suse.de,
       patrizio.bassi@gmail.com, bni.swe@gmail.com, arvidjaar@mail.ru,
       p_christ@hol.gr, ghrt@dial.kappa.ro, jinhong.hu@gmail.com,
       andrew.vasquez@qlogic.com, linux-scsi@vger.kernel.org, bcrl@kvack.org
Subject: Re: Linux 2.6.16-rc3
Message-Id: <20060213001240.05e57d42.akpm@osdl.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30060BD1D9@hdsmsx401.amr.corp.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30060BD1D9@hdsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brown, Len" <len.brown@intel.com> wrote:
>
> My point is that it that on the grand scale of bugs serious enough
>  to have an effect on the course of 2.6.16, this one doesn't qualify
>  unless the same issue is seen on other systems.

I think we can assume that it will be seen there.  2.6.16 is going into
distros and will have more exposure than 2.6.15, let alone 2.6.16-rcX.
