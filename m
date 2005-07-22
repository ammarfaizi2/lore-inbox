Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVGVBhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVGVBhD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 21:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVGVBgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 21:36:55 -0400
Received: from mail.dvmed.net ([216.237.124.58]:42661 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262000AbVGVBfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 21:35:32 -0400
Message-ID: <42E04D5C.5010907@pobox.com>
Date: Thu, 21 Jul 2005 21:35:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukasz Kosewski <lkosewsk@nit.ca>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 0/3] Add disk hotswap support to libata
References: <42E01024.9030600@nit.ca>
In-Reply-To: <42E01024.9030600@nit.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Kosewski wrote:
> Hey all, introductory blurb here.
> 
> This sequence of patches will add a framework to libata to allow for 
> hot-swapping disks in and out.
> 
> There are three patches:
> 01-promise_sataII150_support
> 02-libata_hotswap_infrastructure
> 03-promise_hotswap_support

Pretty cool stuff!

As soon as I finish SATA ATAPI (this week[end]), I'll take a look at 
this.  A quick review of the patches didn't turn up anything terribly 
objectionable, though :)

	Jeff


P.S.  You might want to CC linux-ide as well, on libata patches.
