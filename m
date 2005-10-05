Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbVJELOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbVJELOS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 07:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbVJELOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 07:14:17 -0400
Received: from imag.imag.fr ([129.88.30.1]:34813 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S932597AbVJELOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 07:14:16 -0400
Date: Wed, 5 Oct 2005 13:13:29 +0200
From: Pierre Michon <pierre@no-spam.org>
To: linux-kernel@vger.kernel.org
Subject: Re: freebox possible GPL violation
Message-ID: <20051005111329.GA31087@linux.ensimag.fr>
Reply-To: 4343A886.3030502@cs.aau.dk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Wed, 05 Oct 2005 13:13:29 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>I'm sorry, I must be a bit stupid but I don't see any GPL violation
>here... Could you be a bit more specific on what kind of code, Free is
>keeping under his foot ?
Sorry I realise that my first post wasn't clear.


The fimware that is used with the freebox is a Linux system.
So in the firmware there is the GPL Linux kernel and all the GPL software 
listed on [1] (busybox for example).

Users can't download nor binary firmware nor source code of GPL
software.

The binary firmware is downloaded by the freebox when a new version is
available. This is done on an unknow server with an unknow protocol.

So free keep the Linux kernel modification they have made. You could
see some of the log of their modification on [2] and [3].
They also don't provide the source for the GPL userspace software they
include in the firmware.

Pierre


[1] http://www.f-b-x.net/#firm
[2]
http://openlogging.org:8080/sakura.(none)/max-20040524220224-60268-baea416b9b2da5c2/src?nav=index.html
[3]
http://openlogging.org:8080/chewbacca.proxad.net/rani-20040112173203-20972-c609c93690b2941a/src?nav=index.html
