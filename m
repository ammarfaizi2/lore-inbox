Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWBMHQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWBMHQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 02:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWBMHQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 02:16:19 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:42979
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751185AbWBMHQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 02:16:17 -0500
Date: Sun, 12 Feb 2006 23:13:05 -0800 (PST)
Message-Id: <20060212.231305.38639889.davem@davemloft.net>
To: len.brown@intel.com
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       axboe@suse.de, James.Bottomley@steeleye.com, greg@kroah.com,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       luming.yu@intel.com, lk@bencastricum.nl, sanjoy@mrao.cam.ac.uk,
       helgehaf@aitel.hist.no, fluido@fluido.as, gbruchhaeuser@gmx.de,
       Nicolas.Mailhot@LaPoste.net, perex@suse.cz, tiwai@suse.de,
       patrizio.bassi@gmail.com, bni.swe@gmail.com, arvidjaar@mail.ru,
       p_christ@hol.gr, ghrt@dial.kappa.ro, jinhong.hu@gmail.com,
       andrew.vasquez@qlogic.com, linux-scsi@vger.kernel.org, bcrl@kvack.org
Subject: Re: Linux 2.6.16-rc3
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30060BD1D1@hdsmsx401.amr.corp.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30060BD1D1@hdsmsx401.amr.corp.intel.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Brown, Len" <len.brown@intel.com>
Date: Mon, 13 Feb 2006 02:07:50 -0500

> >- In http://bugzilla.kernel.org/show_bug.cgi?id=5989, Sanjoy 
> >Mahajan has  another regression, but he's off collecting more info.
> 
> We're talking here about a system from 1999 where Windows 98
> refuses to run in ACPI mode and instead runs in APM mode.

If it worked before a change which was installed, it's a regression
regardless of whether another OS tries to use ACPI on that system or
not.  I don't understand how one can use that fact to label this as
not a regression from Linux's perspective.
