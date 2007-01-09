Return-Path: <linux-kernel-owner+w=401wt.eu-S932232AbXAIQmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbXAIQmG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 11:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbXAIQmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 11:42:06 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:35538 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932228AbXAIQmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 11:42:05 -0500
Message-ID: <45A3C5D5.6030105@garzik.org>
Date: Tue, 09 Jan 2007 11:41:57 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Divy Le Ray <divy@chelsio.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, swise@opengridcomputing.com
Subject: Re: [PATCH 1/10] cxgb3 - main header files
References: <20061220124125.6286.17148.stgit@localhost.localdomain>	<45918CA4.3020601@garzik.org> <45A36C22.6010009@chelsio.com>	<45A36E59.30500@garzik.org> <adamz4scgfo.fsf@cisco.com>
In-Reply-To: <adamz4scgfo.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>  > > You can grab the monolithic patch at this URL:
>  > > http://service.chelsio.com/kernel.org/cxgb3.patch.bz2
>  > 
>  > this is in my queue, thanks.  Sorry I didn't indicate that earlier.
> 
> When do you plan to merge it?  For 2.6.20 or .21?

The time for adding new stuff to 2.6.20 is /long/ past.  We stop adding 
things like new drivers when Linus releases 2.6.X-rc1.

	Jeff



