Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVATVE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVATVE6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVATVE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:04:58 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:42691 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261943AbVATVEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:04:55 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Date: Thu, 20 Jan 2005 22:04:58 +0100
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
References: <200501202032.31481.rjw@sisk.pl>
In-Reply-To: <200501202032.31481.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501202204.58816.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 20 of January 2005 20:32, Rafael J. Wysocki wrote:
> Hi,
> 
> The following patch speeds up the restoring of swsusp images on x86-64
> and makes the assembly code more readable (tested and works on AMD64).  It's
> against 2.6.11-rc1-mm1, but applies to 2.6.11-rc1-mm2.  Please consifer for applying.

s/consifer/consider/

Sorry for the typo,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
