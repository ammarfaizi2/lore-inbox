Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbVJEKJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbVJEKJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 06:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbVJEKJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 06:09:05 -0400
Received: from imag.imag.fr ([129.88.30.1]:27382 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S965102AbVJEKJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 06:09:02 -0400
Date: Wed, 5 Oct 2005 12:08:48 +0200
From: Pierre Michon <pierre@no-spam.org>
To: linux-kernel@vger.kernel.org
Subject: Re: freebox possible GPL violation
Message-ID: <20051005100848.GA30563@linux.ensimag.fr>
Reply-To: 43439FF0.9050506@aitel.hist.no
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Wed, 05 Oct 2005 12:08:49 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

>Well, the wifi driver may or may not be under the GPL licence.
>Check that first.  The linux kernel itself is GPL of course.
For the prism card, they should use hostap driver, but there no way to
check that (we can't log in on it). At least [2] list hostap in their
drivers.

>Check where it is downloaded from, that is where linux
>is being distributed from.
According to [1] it is downloaded from the company server. But as we
can't log in the freebox, there no way to check it. Also sniffing adsl
is a bit harder...

>Of course they can still
>keep their scripts secret, their (non-GPL) userland utilities secret,
>their proprietary drivers secret and the hw specs secret.
If you look at [2], their drivers are in the kernel tree. Don't they fall
to GPL ?



[1] http://www.f-b-x.net/
[2]
http://openlogging.org:8080/sakura.(none)/max-20040524220224-60268-baea416b9b2da5c2/src/drivers/freebox?nav=index.html|src/|src/drivers
