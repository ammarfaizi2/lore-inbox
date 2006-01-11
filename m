Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbWAKRUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWAKRUm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWAKRUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:20:42 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:60431 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751533AbWAKRUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:20:41 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Rik van Riel <riel@redhat.com>
Subject: Re: FAT and Microsoft patent?
Date: Wed, 11 Jan 2006 17:20:44 +0000
User-Agent: KMail/1.9
Cc: Christopher Friesen <cfriesen@nortel.com>,
       Roger Heflin <rheflin@atipa.com>,
       "'linux-os (Dick Johnson)'" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
References: <EXCHG2003RXf2LTrpwA00000b29@EXCHG2003.microtech-ks.com> <43C528FC.1060408@nortel.com> <Pine.LNX.4.63.0601111212020.5975@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0601111212020.5975@cuia.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601111720.44759.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 January 2006 17:13, Rik van Riel wrote:
> On Wed, 11 Jan 2006, Christopher Friesen wrote:
> > The question still holds in modified form...will we need to remove this
> > functionality, or is it currently implemented in a way that does not
> > infringe on the patent?
>
> I would not be surprised if the UMSDOS filesystem predated
> VFAT by a few years - but this was all quite a while ago,
> and I'm not sure the patents cover something that UMSDOS
> could have prior art on...

I think the patents are on LFN, which is not VFAT, probably a lot younger, and 
as other people have mentioned on this thread, a lot less of a patent threat.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
