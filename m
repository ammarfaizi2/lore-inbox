Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUANXN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbUANXE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:04:27 -0500
Received: from palrel10.hp.com ([156.153.255.245]:62630 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264442AbUANWxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:53:10 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16389.51280.731508.513970@napali.hpl.hp.com>
Date: Wed, 14 Jan 2004 14:53:04 -0800
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Tolentino <metolent@snoqualmie.dp.intel.com>,
       davidm@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, matthew.e.tolentino@intel.com
Subject: Re: [patch] efivars update for 2.6.1
In-Reply-To: <20040113191015.20415de3.akpm@osdl.org>
References: <200401131824.i0DIOMcA031105@snoqualmie.dp.intel.com>
	<20040113191015.20415de3.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 13 Jan 2004 19:10:15 -0800, Andrew Morton <akpm@osdl.org> said:

  >> Essentially, it converts efivars (i.e. Matt Domsch's driver that
  >> provides access to the EFI variable runtime services) to export
  >> variable information and systab info via sysfs.

  Andrew> I'd need confirmation from David M-T and if poss a quick
  Andrew> review from Greg K-H.

Matt is the owner of efivars so if he is OK with it, that's fine with
me.  My only request is that if/when the patch is accepted that there
is some documentation that makes it clear where one can can get an
updated/matching efibootmgr from.

	--david
