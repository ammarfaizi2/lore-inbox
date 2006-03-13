Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbWCMQyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbWCMQyR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 11:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWCMQyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 11:54:17 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:17675 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751515AbWCMQyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 11:54:16 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New libata PATA patch for 2.6.16-rc1
Date: Mon, 13 Mar 2006 16:39:51 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <1142262431.25773.25.camel@localhost.localdomain>
In-Reply-To: <1142262431.25773.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603131639.51594.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 15:07, Alan Cox wrote:
> Available from
>
> http://zeniv.linux.org.uk/~alan/IDE/
>

Alan, I've been using your patchset for a while on a small-memory machine with 
an AMD IDE controller, so that the legacy PATA port can be used to run an 
optical drive without bloating the vmlinux size with ide-* (already have SCSI 
built in for usb-storage and SATA). I've not had a single problem to date.

What's your merge plan for the 'complete' drivers? Is it reasonable to merge 
some drivers but not others? (I'm ignorant to your core libata changes, I've 
not yet had a chance to read the patch.)

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
