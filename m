Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263151AbVGOCLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbVGOCLU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 22:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbVGOCLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 22:11:14 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:37559 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263151AbVGOCJD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 22:09:03 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Andi Kleen <ak@suse.de>
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
Date: Thu, 14 Jul 2005 22:09:11 -0400
User-Agent: KMail/1.8.1
Cc: Mark Gross <mgross@linux.intel.com>, linux-kernel@vger.kernel.org
References: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel> <p73wtnsx5r1.fsf@bragg.suse.de>
In-Reply-To: <p73wtnsx5r1.fsf@bragg.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507142209.11427.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 July 2005 20:38, Andi Kleen wrote:
> It's basically impossible to regression test swsusp except to release it.
> Its success or failure depends on exactly the driver
> combination/platform/BIOS version etc.  e.g. all drivers have to cooperate
> and the particular bugs in your BIOS need to be worked around etc. Since
> that is quite fragile regressions are common.

I have always wondered how Windows got it right circa 1995 - Version after 
version, several different hardwares and it always works reliably. 
I am using Linux since 1997 and not a single time have I succeeded in getting 
it to suspend and resume reliably. 

Is it such an un-interesting subject to warrant serious effort or there is a 
lot of hardware documentation missing or in general the driver model and OS 
design itself makes it impossible to get suspend / resume right?

Parag
