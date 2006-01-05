Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932966AbWAEMDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932966AbWAEMDu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 07:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932964AbWAEMDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 07:03:50 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:59666 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932966AbWAEMDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 07:03:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=soV+N1/PbmB6Ho7aeUWwFqRFH+FudPrEspXZJw/6GFxmyydjl14b6NFTsBC9tyO2odXkAcdzKm/L5E6TJTFrelLAGqVqpzCzY7YPYRxt2Nv6GO3IzTh1viS7EF/8wriq6ZyWGMj7QCOYABhQDCrhlAISBXcx9UJ2QNNuCxVCHfk=
From: Dane Mutters <dmutters@gmail.com>
Organization: DA Enterprises
To: linux-kernel@vger.kernel.org
Subject: Re: (1) ACPI messes up Parallel support in kernels >2.6.9
Date: Thu, 5 Jan 2006 04:03:48 -0800
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601050403.48703.dmutters@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all.

> hm, regressions are bad and the fact that it _used_ to work meand that we
> should be able to make it work again.
> 
> Could you please raise a bug reports against acpi at bugzilla.kernel.org? 
> It might help if that report includes the output of `dmesg -s 1000000' for
> both working and non-working kernels.
> 
> Thanks.

Done...whoops...forgot to add dmesg output for working kernel.  I'll post 
another comment when I reboot.

> This may be a PnP bug.  If you can provide further information, I'll
> look into it.
> 
> Thanks,
> Adam
> 

What oher information would you like me to post?

--Dane
