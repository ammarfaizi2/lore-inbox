Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbULBODE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbULBODE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 09:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbULBODE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 09:03:04 -0500
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:56241
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261620AbULBODB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 09:03:01 -0500
Message-ID: <41AF207F.6060704@portrix.net>
Date: Thu, 02 Dec 2004 15:02:39 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Dittmer <j.dittmer@portrix.net>
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, kuba@mareimbrium.org,
       greg@kroah.com, bryder@sgi.com, linux-kernel@vger.kernel.org,
       edwin@harddisk-recovery.nl
Subject: Re: FTDI SIO patch to allow custom vendor/product IDs.
References: <20041202124831.GA31745@bitwizard.nl> <41AF1F4C.2030707@portrix.net>
In-Reply-To: <41AF1F4C.2030707@portrix.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer wrote:
> Rogier Wolff wrote:
> 
>>+MODULE_PARM(vendor, "i");
>>+MODULE_PARM_DESC(vendor, "User specified USB idVendor");
>>+
>>+MODULE_PARM(product, "i");
>>+MODULE_PARM_DESC(product, "User specified USB idProduct");
> 
> 
> Use module_param instead.

Sorry, I didn't see that it's an 2.4 patch ;-)

Jan
