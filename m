Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbVJEQG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbVJEQG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbVJEQG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:06:56 -0400
Received: from imag.imag.fr ([129.88.30.1]:3748 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1030199AbVJEQGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:06:55 -0400
Date: Wed, 5 Oct 2005 18:06:45 +0200
From: Pierre Michon <pierre@no-spam.org>
To: linux-kernel@vger.kernel.org
Subject: Re: freebox possible GPL violation
Message-ID: <20051005160645.GA1295@linux.ensimag.fr>
Reply-To: 20051005154923.GA14366@snarc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Wed, 05 Oct 2005 18:06:45 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Why does it need to reboot when there is a new firmware ?

>To use it, exactly like when you reboot your pc to change kernels.
Yes but in this case you have just rebooted. It is like when you reboot
to change your kernel, the new kernel notice it is newer and reboot...


If it has an external firmware in the adsl chips for downloading the
linux kernel, why after you download the new linux firmware, you need to
reboot ?

I forgot to say that in case of a new firmware, you can see the upload
(and flash ?) of the new firmware with ____,----- symbol on led. See
step 6 of [1].

So why in case a new firmware you need to wait more time (about 10
second) that the case where there not new firmware ?

>> How they manage to download the firmware (need led driver, ppp, http,
>> adsl driver, atm stack, ...)

>How do you think some random network card with do netbooting works ?
>(got a led driver, ipv4 simplified "stack", dhcp & tftp capabilities)

>Just like your pc has a BIOS to search for booting devices
Adsl is far more complex than ethernet...

>> Please suggest other mailling lists.
>the one you CC at first @lists.gpl-violations.org and only this one ...
Ok, let's continue on this mailling list.
Register is needed to post, but I think it is worth to continue, to
clarify how works the freebox and some wrong assuptions.

Pierre

[1] http://forums.grenouille.com/index.php?showtopic=14659
