Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTFPIi5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 04:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTFPIi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 04:38:57 -0400
Received: from [62.67.222.139] ([62.67.222.139]:30945 "EHLO kermit")
	by vger.kernel.org with ESMTP id S263597AbTFPIi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 04:38:56 -0400
Date: Mon, 16 Jun 2003 10:31:51 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71-mm1
Message-ID: <20030616083151.GA1580@sexmachine.doom>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030615015024.6d868168.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030615015024.6d868168.akpm@digeo.com>
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one compiles, boots fine, devmapper seems to be happy again.
But this one freezes after a while like 2.5.70-mm9. And as said,
2.5.70-mm4 is rockstable on this machine.

Yesterday I was clicking around in the konqueror window, when sound
began too loop for a second (not more than two), than there was a pause
of a second, then the desktop freezed, no ping.

MagicSysReq (Alt+Print+P) didn't do it either. So ATM I am trying to get
this serial console thing to work, may be that helps...

Furthermore my kernel is tainted, so I have to change my X config. Then
I am waiting for the next freeze :)

Has there something changed, which may be the nvidia kernel module won't
like after 2.5.70-mm8?

Konsti

-- 
2.5.71-mm1
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 18 min, 
