Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTEVRof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 13:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTEVRof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 13:44:35 -0400
Received: from pc1-cmbg4-4-cust110.cmbg.cable.ntl.com ([81.96.70.110]:47626
	"EHLO thekelleys.org.uk") by vger.kernel.org with ESMTP
	id S262872AbTEVRof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 13:44:35 -0400
Message-ID: <3ECD0F8A.5080409@thekelleys.org.uk>
Date: Thu, 22 May 2003 18:57:30 +0100
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-GB; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: ranty@debian.org
CC: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Re: request_firmware() hotplug interface, third round
 and a halve
References: <20030517221921.GA28077@ranty.ddts.net> <20030521072318.GA12973@kroah.com> <20030521185212.GC12677@ranty.ddts.net> <20030521200736.GA2606@kroah.com> <20030522153154.GD13224@ranty.ddts.net>
In-Reply-To: <20030522153154.GD13224@ranty.ddts.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works great for me now.

It's noisy: I'd remove/disable the printks in firmware_data_read and firmware_data_write
before it goes in.

Cheers,

Simon.

