Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTKIWQA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 17:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbTKIWQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 17:16:00 -0500
Received: from [62.67.222.139] ([62.67.222.139]:1167 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S262610AbTKIWP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 17:15:58 -0500
Date: Sun, 9 Nov 2003 23:15:46 +0100
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird partititon recocnising problem in 2.6.0-testX
Message-ID: <20031109221546.GA11520%konsti@ludenkalle.de>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: Stefan Smietanowski <stesmi@stesmi.com>,
	linux-kernel@vger.kernel.org
References: <20031109011205.GA21914%konsti@ludenkalle.de> <20031109023625.GA15392@win.tue.nl> <20031109034940.GA8532@zappa.doom> <20031109115857.GA15484@win.tue.nl> <3FAE2EC1.6080307@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAE2EC1.6080307@stesmi.com>
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i-ja.1
X-Spam-Score: 3.2
X-Spam-Report: Spam detection software, running on the system "kermit", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	admin@mail.ku-gbr.de for details.
	Content preview:  * Stefan Smietanowski <stesmi@stesmi.com> [Sun, Nov 09,
	2003 at 01:10:41PM +0100]: > >An impossible error. Recompile your
	kernel. We recompiled it from fresh unpacked tar.bz2 same error.
	Instead of gcc-2.95.4 we tried gcc-3.3.2 same errot. I got serial
	console running, so a detailed log is at [...] 
	Content analysis details:   (3.2 points, 10.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 RCVD_IN_NJABL_DIALUP   RBL: NJABL: dialup sender did non-local SMTP
	[145.254.143.166 listed in dnsbl.njabl.org]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[Dynamic/Residential IP range listed by]
	[easynet.nl DynaBlock - <http://dynablock.easynet.nl/errors.html>]
	0.1 RCVD_IN_NJABL          RBL: Received via a relay in dnsbl.njabl.org
	[145.254.143.166 listed in dnsbl.njabl.org]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stefan Smietanowski <stesmi@stesmi.com> [Sun, Nov 09, 2003 at 01:10:41PM +0100]:
> >An impossible error. Recompile your kernel.

We recompiled it from fresh unpacked tar.bz2 same error. Instead of
gcc-2.95.4 we tried gcc-3.3.2 same errot. I got serial console running,
so a detailed log is at

http://www.ludenkalle.de/jan.log

My friend is trying to add this printk stuff (his PC) lets see...

Konsti

-- 
2.6.0-test6-mm4
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 4:58, 1 user
