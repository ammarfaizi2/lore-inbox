Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWEEAMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWEEAMZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 20:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWEEAMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 20:12:24 -0400
Received: from wx-out-0102.google.com ([66.249.82.199]:55499 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932405AbWEEAMY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 20:12:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lcou6yBSaFdWVfzP/iLdQJE3ASh77jsRR3BLyx4WqwpPaz2elMHR1NZ91huzMO8pLO8Hskxt26/lXjmcNhap6KdWCgmnS0uuazpaupFHhWKgL/XnAYigNOUwcrVzkgkz2mQwC06E0Mf4ImMlwVMClY+IYASFwfdzJJyuTaK2oCA=
Message-ID: <2151339d0605041712uad6cb49p3f7bffd2c45ceb24@mail.gmail.com>
Date: Thu, 4 May 2006 17:12:23 -0700
From: "Nathan Becker" <nathanbecker@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: USB 2.0 ehci failure with large amount of RAM (4GB) on x86_64
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20060504052751.GA23054@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2151339d0605032148n5d6936ay31ab017fbabc65b3@mail.gmail.com>
	 <2151339d0605032152g64ec77bfhe90dc08180463c31@mail.gmail.com>
	 <20060504052751.GA23054@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried 2.6.17-rc3 and the problem persists.  I don't see any messages
about EHCI BIOS handoffs.
