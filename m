Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752270AbWAFK0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbWAFK0L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 05:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbWAFK0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 05:26:11 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:11920 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1752189AbWAFK0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 05:26:10 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: State of the Union: Wireless
Date: Fri, 6 Jan 2006 10:26:10 +0000
User-Agent: KMail/1.9
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <5rRp0-4X1-3@gated-at.bofh.it> <43BE027B.4010806@shaw.ca>
In-Reply-To: <43BE027B.4010806@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601061026.11007.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 January 2006 05:39, Robert Hancock wrote:
> Jeff Garzik wrote:
> > * Release early, release often.  Pushing from an external repository to
> >   the official kernel tree every few months creates more problems
> >   than it solves.  Out-of-tree drivers fail to take advantage of
> >   recent kernel changes and coding practices, which leads to bugs and
> >   incompatibilities.  Slow pushing leads to huge periodic updates,
> >   which are awful for debugging, testing, and general use.
>
> I think this is an especially big problem, from a user's perspective at
> least.. I'm tired of patching up my laptop kernel with the latest
> ieee80211 and ipw2200 on every update because the mainline kernel
> contains an ancient version which is almost useless to me, and the Intel
> guys apparently don't feel like merging newer versions upstream until
> they get it perfect, or something..

Robert, this was _one_ kernel, 2.6.14, and has since been rectified. Install 
2.6.15 and be happy with your bleeding edge driver supporting firmware 2.4.

The last thing we need is Yet Another Flame War about the ipw2x00 drivers. 
They're some of the best drivers in the wireless tree.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
