Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTJ2InR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 03:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTJ2InR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 03:43:17 -0500
Received: from [62.67.222.139] ([62.67.222.139]:3538 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S261929AbTJ2InQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 03:43:16 -0500
Date: Wed, 29 Oct 2003 09:42:12 +0100
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: Jakub Krajcovic <news.receive@zoznam.sk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Floppy in 2.6
Message-ID: <20031029084212.GA4001%konsti@ludenkalle.de>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: Jakub Krajcovic <news.receive@zoznam.sk>,
	linux-kernel@vger.kernel.org
References: <20031028232054.1d452baa.news.receive@zoznam.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031028232054.1d452baa.news.receive@zoznam.sk>
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i-ja.1
X-Spam-Score: 2.6
X-Spam-Report: Spam detection software, running on the system "kermit", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	admin@mail.ku-gbr.de for details.
	Content preview:  * Jakub Krajcovic <news.receive@zoznam.sk> [Tue, Oct
	28, 2003 at 11:20:54PM +0100]: > > I've been using the 2.6 test kernels
	from when -test4 was released, > but only today have i noticed that my
	floppy drive is nowhere to be > found. [...] 
	Content analysis details:   (2.6 points, 10.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[Dynamic/Residential IP range listed by]
	[easynet.nl DynaBlock - <http://dynablock.easynet.nl/errors.html>]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[213.6.67.44 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jakub Krajcovic <news.receive@zoznam.sk> [Tue, Oct 28, 2003 at 11:20:54PM +0100]:
> 
> I've been using the 2.6 test kernels from when  -test4  was  released,
> but only today have i noticed that my floppy drive is  nowhere  to  be
> found.

Enable ISA-Bus Support. Then, as the others point out, first item in
Block Devices.

Konsti

-- 
2.6.0-test6-mm4
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 26 min, 
