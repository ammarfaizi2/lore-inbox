Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265035AbTFCOqU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265036AbTFCOqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:46:20 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:43507 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S265035AbTFCOqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:46:19 -0400
Subject: Re: 2.5.70 and 2.5.70-mm3 hang on bootup
From: Martin Schlemmer <azarah@gentoo.org>
To: John Stoffel <stoffel@lucent.com>
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <16092.43423.958091.657360@gargle.gargle.HOWL>
References: <Pine.LNX.4.53.0306011742490.3125@dot.kde.org>
	 <16090.15708.707835.911577@gargle.gargle.HOWL>
	 <16090.48773.258921.532437@gargle.gargle.HOWL>
	 <16092.43423.958091.657360@gargle.gargle.HOWL>
Content-Type: text/plain
Organization: 
Message-Id: <1054651654.5268.64.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 03 Jun 2003 16:47:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-03 at 15:58, John Stoffel wrote:

> Thanks for all the help, my initial thoughts that APIC was the root of
> my problem was wrong, it was all ACPI issues.  Maybe we should put in
> a note in the Kconfig help entries for people to disable ACPI if they
> enable SMP and/or UP APIC options?
> 

Both my previous board (Asus P4T533-C with 850E chipset) and current
one (Asus P4C800 with 875P chipset) works fine with ACPI, APIC, and
IO-APIC enabled ....


-- 
Martin Schlemmer


