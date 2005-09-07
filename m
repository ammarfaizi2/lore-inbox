Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVIGTZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVIGTZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 15:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVIGTZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 15:25:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59918 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751277AbVIGTZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 15:25:16 -0400
Date: Wed, 7 Sep 2005 20:25:04 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Max Asbock <masbock@us.ibm.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, amax@us.ibm.com,
       ralf@linux-mips.org, starvik@axis.com
Subject: Re: [FINAL WARNING] Removal of deprecated serial functions - please update your drivers NOW
Message-ID: <20050907202504.F19199@flint.arm.linux.org.uk>
Mail-Followup-To: Max Asbock <masbock@us.ibm.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, amax@us.ibm.com,
	ralf@linux-mips.org, starvik@axis.com
References: <20050831103352.A26480@flint.arm.linux.org.uk> <1126120374.17335.169.camel@w-amax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1126120374.17335.169.camel@w-amax>; from masbock@us.ibm.com on Wed, Sep 07, 2005 at 12:12:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 12:12:54PM -0700, Max Asbock wrote:
> Here is a patch for the ibmasm driver. Let me know it I missed
> something.

Thanks.  Does it still need to include serial.h?

Also, can I have a signed-off-by line as per the DCO v1.1 please
(see Documentation/SubmittingPatches) ?

Thanks again.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
