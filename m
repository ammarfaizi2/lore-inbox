Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTFYNJb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 09:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTFYNJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 09:09:31 -0400
Received: from [62.67.222.139] ([62.67.222.139]:12768 "EHLO kermit")
	by vger.kernel.org with ESMTP id S263187AbTFYNJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 09:09:30 -0400
Date: Wed, 25 Jun 2003 15:23:36 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Success stories, disappearing Oopses and ps/2 keyboard
Message-ID: <20030625132336.GA1579@sexmachine.doom>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030624164026.GA2934@sexmachine.doom> <1056493814.1032.253.camel@w-jstultz2.beaverton.ibm.com> <20030625081313.GA1747@sexmachine.doom> <200306251127.37944.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306251127.37944.lkml@kcore.org>
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan De Luyck <lkml@kcore.org> [Wed, Jun 25, 2003 at 11:27:37AM +0200]:
> 
> I'll test with that clock=pit option later, when I have the chance to reboot.

I tested it now and with pit the IO-APIC is not getting alog with it at
boot time, is it worth to write down the error message?

It resultet in something like "clock not usable" or something. Hell
wait, I can capture it at serial console :-) 

Konsti

-- 
2.5.73-mm1
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 18 min, 
