Return-Path: <linux-kernel-owner+w=401wt.eu-S1752625AbWLVUOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbWLVUOz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 15:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbWLVUOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 15:14:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:31938 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbWLVUOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 15:14:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j9/iMNLrOjqUrLB7YJFRaeK5/A3BUHHUhDXBpunMVXFCIy5lhznaztDC7ukh5ClkzMdG+kfF1Nwbcd9lGKDTv3BVbXXDdSvU5XQU1q1DcvSGE8U2iNM6VflPFFnW6wi6ZNQXEUe694Cn0BYHyv76+RXoUVYLBbmZGOlMs1xivX4=
Message-ID: <d120d5000612221214h638a79erc574a62f4e8a85f9@mail.gmail.com>
Date: Fri, 22 Dec 2006 15:14:53 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [PATCH] input/spi: add ads7843 support to ads7846 touchscreen driver
Cc: "Nicolas Ferre" <nicolas.ferre@rfo.atmel.com>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Patrice Vilchez" <patrice.vilchez@rfo.atmel.com>
In-Reply-To: <200612221131.25858.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4582BD29.4020203@rfo.atmel.com>
	 <200612201513.09705.david-b@pacbell.net>
	 <458A875D.3000801@rfo.atmel.com>
	 <200612221131.25858.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/06, David Brownell <david-b@pacbell.net> wrote:
> On Thursday 21 December 2006 5:08 am, Nicolas Ferre wrote:
>
> > > Let me try to sort out the mess with those updates, and ask you to refresh
> > > this ads7843 support against that more-current ads7846 code.
> >
> > Ok, let me know when you have a newer code. I will try to adapt my
> > ads7843 support then.
>
> I just sent these updates to LKML ... though the address I had for Dmitry
> sees to have gone bad, I do see all six patches in the list archives.
>

I changed my ISP. Please use either:

dmitry.torokhov@gmail.com
dtor@mail.ru
dtor@insightbb.com

The last one may go bad if I ever change ISP again but I intend to
keep the first 2 indefinitely.

I'll fish the patches from LKML.

-- 
Dmitry
