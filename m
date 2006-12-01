Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031678AbWLABJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031678AbWLABJB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 20:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031680AbWLABJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 20:09:01 -0500
Received: from ip-85-160-27-120.eurotel.cz ([85.160.27.120]:62224 "EHLO
	localhost") by vger.kernel.org with ESMTP id S1031678AbWLABJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 20:09:00 -0500
Date: Fri, 1 Dec 2006 02:08:59 +0100
From: "gary.czek" <gary@czek.info>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ICH6M SATA Controller, SATA2 NCQ disk and high iowait CPU time
Message-ID: <20061201020859.21db6dcb@localhost>
In-Reply-To: <456F7C69.90800@gmail.com>
References: <1164404380.20334.37.camel@localhost>
	<456A5936.9080903@gmail.com>
	<20061130180646.66dc622b@localhost>
	<456F7C69.90800@gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.6; i486-pc-linux-gnu)
X-Operating-System: Ubuntu Edgy Eft (Linux i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Dec 2006 09:50:49 +0900

Tejun Heo <htejun@gmail.com> wrote:

> Your machine is thrashing.  Working set size is over the available
> memory and pages are continuously getting dropped and then brought
> back. Run top and press 'M' after the list showed up.  It will show
> who are consuming all the memory.  Adding 1G should solve the problem
> but just another 256M will make a big difference too.
 
Well... The problem is solved.
Thanks a lot for your time.
I look forward for additional 1Gig.

Thanks a lot twice more time.
