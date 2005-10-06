Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVJFMCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVJFMCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 08:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVJFMCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 08:02:07 -0400
Received: from imag.imag.fr ([129.88.30.1]:12943 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1750814AbVJFMCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 08:02:05 -0400
Date: Thu, 6 Oct 2005 14:01:35 +0200
From: Pierre Michon <pierre@no-spam.org>
To: linux-kernel@vger.kernel.org
Subject: Re: freebox possible GPL violation
Message-ID: <20051006120135.GA1002@linux.ensimag.fr>
Reply-To: 4344F39B.10806@cs.aau.dk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Thu, 06 Oct 2005 14:01:36 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>I might have misunderstood but I think that if you buy the hardware you
>cannot connect it to the DSLAM network anymore. So that only the boxes
>they own are connected to the DSLAM.

Again have you any proof that there aren't any Linux firmware in the
flash of the freebox ?
How do you explain that the boot sequence isn't stateless ?
Why in case of a firmware update, you have a special state of 10 seconds
were the freebox seem to download and write some data somewhere ?

So yes may be you can't connect anymore to the free DSLAM, but there is
may be still GPL data in the flash.

>Are you sure this point has been clarified in court in the past ?
>If not, I would bet on it (for the specific case of settop boxes).

For french law I don't know, but someone on gpl-violation this is true
for de and au.

>I mentioned in another mail the case of a mobile phone network
>infrastructure where the network nodes to which mobile phones are
>connecting are running Linux. It seems to be an "internal use" (as it
>never leak out of the company network) and yet providing a service to
>customers.

No the freebox is more like a dvb box that is lended by a satellite
provider and could do firmware update via satellite.

I don't know if there are similar case for dvb box.


Pierre
