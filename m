Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264087AbTFYH7L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 03:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTFYH7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 03:59:11 -0400
Received: from [62.67.222.139] ([62.67.222.139]:19675 "EHLO kermit")
	by vger.kernel.org with ESMTP id S264087AbTFYH7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 03:59:09 -0400
Date: Wed, 25 Jun 2003 10:13:13 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Success stories, disappearing Oopses and ps/2 keyboard
Message-ID: <20030625081313.GA1747@sexmachine.doom>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030624164026.GA2934@sexmachine.doom> <1056493814.1032.253.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056493814.1032.253.camel@w-jstultz2.beaverton.ibm.com>
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning :-)

* john stultz <johnstul@us.ibm.com> [Tue, Jun 24, 2003 at 03:30:14PM -0700]:
> 
> Could you further explain what you mean by key "bouncing"?

Well, it should become a correct translation of german "prellen" (Wie
geht das in Englisch?).

> Do you mean the keyboard repeat rate is too fast? If so, could you let

No, that would be no Problem. Often, if I browse in mutt and press Arrow
Keys, it is autorepeated suddenly but I only pressed the Key shortly!
The Kernel does not realize it is released since ages. Pressing again
the kernel stops repeating. That happens with all keys and when with
arrow or PageUp/Down keys in slrn it drives me mad!

See also:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105447074931080&w=2

This happens with 2 PS/2 Keyboards plugged into a SIS7xx and an intel
845PE Board. Using USB Keyboards works like a charme...

> me know more details about the system? Also could you try booting w/
> "clock=pit" and let me know if the problem persists?

Yes, curious what that means, will know more this evening :)

Happy hacking!

Konsti


-- 
2.5.73-mm1
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 46 min, 
