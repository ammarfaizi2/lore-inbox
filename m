Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVCCTny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVCCTny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVCCTnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:43:14 -0500
Received: from bender.bawue.de ([193.7.176.20]:56715 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261160AbVCCTcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:32:35 -0500
Date: Thu, 3 Mar 2005 20:32:29 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [SATA] libata-dev queue updated
Message-ID: <20050303193229.GA10265@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <3Ds62-5AS-3@gated-at.bofh.it> <200503022034.j22KYppm010967@bear.sommrey.de> <422641AF.8070309@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422641AF.8070309@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 05:43:59PM -0500, Jeff Garzik wrote:
> Joerg Sommrey wrote:
> >Jeff Garzik wrote:
> >>Patch:
> >>http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.11-rc5-bk4-libata-dev1.patch.bz2
> >
> >
> >Still not usable here.  The same errors as before when backing up:
> 
> Please try 2.6.11 without any patches.
Plain 2.6.11 doesn't work either.  All of 2.6.10-ac11, 2.6.11-rc5,
2.6.11-rc5 + 2.6.11-rc5-bk4-libata-dev1.patch and 2.6.11 fail with the
same symptoms. 

Reverting to stable 2.6.10-ac8 :-)

-jo

-- 
-rw-r--r--  1 jo users 63 2005-03-03 20:23 /home/jo/.signature
