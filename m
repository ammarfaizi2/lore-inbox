Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUJFE0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUJFE0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 00:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUJFE0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 00:26:22 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:14250 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267165AbUJFE0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 00:26:20 -0400
Message-ID: <416373E8.4020900@yahoo.com.au>
Date: Wed, 06 Oct 2004 14:26:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrea Arcangeli <andrea@novell.com>, Robert Love <rml@novell.com>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
References: <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au> <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost> <20041006015515.GA28536@havoc.gtf.org> <41635248.5090903@yahoo.com.au> <20041006020734.GA29383@havoc.gtf.org> <20041006031726.GK26820@dualathlon.random> <4163660A.4010804@pobox.com> <20041006040323.GL26820@dualathlon.random> <41636FCF.3060600@pobox.com>
In-Reply-To: <41636FCF.3060600@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> 
> Preempt will always be something I ask people to turn off when reporting 
> driver bugs;
> 

That's a valid angle of attack. If their problem goes away, that
helps narrow it down to a specific type of bug in your driver.
