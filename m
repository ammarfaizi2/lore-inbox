Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262789AbVCPUb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbVCPUb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 15:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbVCPUb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 15:31:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58775 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262786AbVCPUbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 15:31:53 -0500
Message-ID: <42389797.7000004@pobox.com>
Date: Wed, 16 Mar 2005 15:31:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] SCSI updates for 2.6.11
References: <1110934411.5685.39.camel@mulgrave> <42387C7C.9040407@pobox.com> <1111003679.5635.3.camel@mulgrave>
In-Reply-To: <1111003679.5635.3.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Wed, 2005-03-16 at 13:35 -0500, Jeff Garzik wrote:
> 
>>Are my 3ware bugfixes in the queue?  Currently 3ware claims it handled 
>>the interrupt, even the interrupt is a shared one and the event was 
>>meant for another driver.
> 
> 
> Not in my queue ... you could try Adam Radford directly ...

More info?  Were they dropped on purpose, or just never arrived?
If dropped on purpose, what was the reason?

http://marc.theaimsgroup.com/?l=linux-scsi&m=110974795732192&w=2
http://marc.theaimsgroup.com/?l=linux-scsi&m=110974807701325&w=2
http://marc.theaimsgroup.com/?l=linux-scsi&m=110974812119775&w=2
http://marc.theaimsgroup.com/?l=linux-scsi&m=110974869410494&w=2

	Jeff


