Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267527AbUHSXgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267527AbUHSXgD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 19:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267531AbUHSXgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 19:36:03 -0400
Received: from the-village.bc.nu ([81.2.110.252]:30342 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267527AbUHSXgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 19:36:00 -0400
Subject: Re: DTrace-like analysis possible with future Linux kernels?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Julien Oster <usenet-20040502@usenet.frodoid.org>
Cc: Miles Lane <miles.lane@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87hdqyogp4.fsf@killer.ninja.frodoid.org>
References: <200408191822.48297.miles.lane@comcast.net>
	 <87hdqyogp4.fsf@killer.ninja.frodoid.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092954824.28931.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 19 Aug 2004 23:33:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-20 at 00:23, Julien Oster wrote:
> Come on, it's profiling. As presented by that article, it is even more
> micro optimization than one would think. What with tweaking the disk
> I/O improvements and all... If my harddisk accesses were a microsecond
> more immediate or my filesystem giving a quantum more transfer rate,
> it would be nice, but I certainly wouldn't get enthusiastic and I bet
> nobody would even notice.

Yes and no. LTT is just profiling too. Both of them are making people
notice because they allow that system profiling work to be done by 
two-banana grade operations staff not by the company wizard.

Neither are perfect - users want a "why is it going slow button"
with a "make it work" and "beat the crap out of the user who caused it"
option set.

"Profiling for the people" as it were.. (as opposed to the current
fad of 'profiling the people')

Alan

