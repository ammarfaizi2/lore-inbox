Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbTFAMPx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 08:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbTFAMPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 08:15:53 -0400
Received: from [62.67.222.139] ([62.67.222.139]:44746 "EHLO kermit")
	by vger.kernel.org with ESMTP id S264547AbTFAMPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 08:15:51 -0400
Date: Sun, 1 Jun 2003 14:29:03 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: Re: weird keyboard with 2.5.70
Message-ID: <20030601122903.GA18783@sexmachine.doom>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
References: <3ED93A62.9080504@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED93A62.9080504@g-house.de>
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Kujau <evil@g-house.de> [Sun, Jun 01, 2003 at 01:27:30AM +0200]:
> 
> hm, i guessed this was an important thing "in the old days" (TM),
> i never had problems when "hotplugging" ps/2. nevertheless - i _have_ to
> unplug/replug the ps/2 keyboard to actually _use_ it. after this is done
> the keyboard is working right (and the mainboard, too :-))

Today I realize it more signifikant here. Sometimes a pressed key hangs,
the kernel realizes not, that it was a single click. Then the Key is
repeyted until I press it once again.

Christian, do you get this error only in X or at console too?

Furthermore my ps2 kbd is usable without hotplugging it, though.

The strange thing happens very often using ssh.

In earlyer days I had a similair Problem with an SiS chipset board
@work and 2.4.x ac kernels, there only an usb keyboard is usable.
This happens only happens running X and IIRC this was/is an xfree86 bug
there.

But here @home I get this error for the 1st time with this otherwise
master piece of software being 2.5.70-mm3 :) on an i845PE chipset.

I discovered this only running X 'cause I did not do much console work
with this kernel, since it is so young :)

regards,
Konstantin

-- 
2.5.70-mm3
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 1:43, 19 users
