Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbVIFVLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVIFVLR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbVIFVLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:11:17 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:23969 "EHLO nic.netdirect.ca")
	by vger.kernel.org with ESMTP id S1750957AbVIFVLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:11:16 -0400
Date: Tue, 6 Sep 2005 17:08:01 -0400
From: Chris Frey <cdfrey@netdirect.ca>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: "Budde, Marco" <budde@telos.de>, linux-kernel@vger.kernel.org
Subject: Re: kbuild & C++
Message-ID: <20050906210801.GA27897@netdirect.ca>
References: <809C13DD6142E74ABE20C65B11A2439809C4BD@www.telos.de> <1126006234.31664.13.camel@tara.firmix.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126006234.31664.13.camel@tara.firmix.at>
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: <cdfrey@netdirect.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 01:30:34PM +0200, Bernd Petrovitsch wrote:
> Yes, because the official Linux kernel is pure C (using some gcc
> extensions).
> There is http://netlab.ru.is/exception/LinuxCXX.shtml but it is
> a) not integrated (and will probably never) and
> b) you can't use parts of C++ anyway with it.

All the language features are supported, according to them.  The standard
library is not available that I can see, but it's not available in C
either, in the kernel.

- Chris

