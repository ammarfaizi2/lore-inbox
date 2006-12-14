Return-Path: <linux-kernel-owner+w=401wt.eu-S1751944AbWLNXcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbWLNXcU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbWLNXcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:32:20 -0500
Received: from www.nabble.com ([72.21.53.35]:57885 "EHLO talk.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbWLNXcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:32:19 -0500
X-Greylist: delayed 1461 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 18:32:19 EST
Message-ID: <7883193.post@talk.nabble.com>
Date: Thu, 14 Dec 2006 15:07:58 -0800 (PST)
From: seven <horia.muntean@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Temporary random kernel hang
In-Reply-To: <20061214141034.790b2a8c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: horia.muntean@gmail.com
References: <7755634.post@talk.nabble.com> <20061209230746.7e33b40f.akpm@osdl.org> <7800583.post@talk.nabble.com> <20061214141034.790b2a8c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:
> 
> No, I wasn't ignoring you for four days.  Please, always do reply-to-all.
> 

I am using nabble's interface to post messages ( www.nabble.com ) and I am
not subscribed to the mailing list, so it's possible that this is the cause
of the direct mail.


Andrew Morton wrote:
> 
> It's certainly different.  It is hard to work out what might be going
> on in there, but there's no obvious sign of misbehaviour.  It could be
> that
> the application has simply gone berzerk and is doing a larger number or
> expensive system calls.
> 
> The next step would be to try to catch one of these eposides with strace.
> 

I will try. Thank you.

Regards,
Horia 
-- 
View this message in context: http://www.nabble.com/Temporary-random-kernel-hang-tf2779860.html#a7883193
Sent from the linux-kernel mailing list archive at Nabble.com.

