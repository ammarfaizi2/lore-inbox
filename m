Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265476AbTFMShA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbTFMSg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:36:59 -0400
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:3462
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id S265476AbTFMSgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:36:36 -0400
From: "jds" <jds@soltis.cc>
To: Dominik Brodowski <linux@brodo.de>, akpm@diego.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems in kernel 2.4.70-mm9 with pcmcia xircom_cb
Date: Fri, 13 Jun 2003 12:21:35 -0600
Message-Id: <20030613181745.M128@soltis.cc>
In-Reply-To: <20030613183320.GA4765@brodo.de>
References: <20030613183320.GA4765@brodo.de>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 180.175.220.238 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi:

    Thanks ....... again, my pcmcia card bus xircom_cb working good.

  Regards.


---------- Original Message -----------
From: Dominik Brodowski <linux@brodo.de>
To: jds@soltis.cc, akpm@diego.com
Sent: Fri, 13 Jun 2003 20:33:20 +0200
Subject: Re: Problems in kernel 2.4.70-mm9 with pcmcia xircom_cb

> Hi "jds",
> 
> Please run "oldconfig" on your .config, and select 
> 
> CONFIG_YENTA  CardBus yenta-compatible bridge support (NEW) "y"
> 
> (Or run any other config tool of your choice and adjust this setting).
> 
> If CONFIG_YENTA wasn't set before, this is likely the cause of the problem.
> If not, please contact me again.
> 
> 	Dominik
------- End of Original Message -------

