Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWGGS3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWGGS3c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 14:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWGGS3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 14:29:32 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:12553 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1751222AbWGGS3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 14:29:31 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Gregoire Favre <gregoire.favre@gmail.com>
Subject: Re: Pata via ?
Date: Fri, 7 Jul 2006 19:29:57 +0100
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060707180751.GA8891@gmail.com>
In-Reply-To: <20060707180751.GA8891@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607071929.57315.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 July 2006 19:07, Gregoire Favre wrote:
> Hello,
>
> at every rc kernels release I look to have pata_via.c included because
> for me it works very well since a long time in mm kernels :-)
>
> I have fetched libata-dev and even there, there is no pata_via...
>
> Any reason for this ?

This is a patch from Alan; you're best using the broken out patches in -mm 
(because Andrew maintains these) or the rebases Alan occasionally does 
available here:

http://zeniv.linux.org.uk/~alan/IDE/

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
