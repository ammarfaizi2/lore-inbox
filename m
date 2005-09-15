Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbVIOMSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVIOMSf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 08:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVIOMSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 08:18:35 -0400
Received: from qproxy.gmail.com ([72.14.204.194]:21797 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751176AbVIOMSe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 08:18:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tz1t+fcVNoFlkJxVwqNdYNkr2WSYdjolZYR9cxM2hjQWt5LGOzrRMBrzUHzFwHQRrdXlKFDaNcydcHqFzcj3kMu/PFkTFl/HoyRPh0sx17iv2UcXhGUq7gml+XCMM1fzaHB6TxZ6IddCfXMKdA5ymKyUdnP+vtIsFEHYfv6eFA4=
Message-ID: <a598610305091505184a8aa8fd@mail.gmail.com>
Date: Thu, 15 Sep 2005 14:18:31 +0200
From: Ivan Korzakow <ivan.korzakow@gmail.com>
Reply-To: ivan.korzakow@gmail.com
To: fawadlateef@gmail.com
Subject: Re: best way to access device driver functions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1e62d137050915010361d10139@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a5986103050915004846d05841@mail.gmail.com>
	 <1e62d137050915010361d10139@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Adding ioctl in driver is not a good idea especially for 2.6.x series
> kernel, rather use sysfs which is in kernel 2.6.x to support
> user/kernel interaction too with other usage .....
> 


Thanks for your answer. I started looking in sysfs and driver model.

Could you explain me why ioctl should be avoided ? Is it going to be
deprecated in future kernel ?

Regards,

Ivan
