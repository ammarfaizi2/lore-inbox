Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVCVAf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVCVAf2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVCVAet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:34:49 -0500
Received: from A.painless.aaisp.net.uk ([81.187.81.51]:14825 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S262213AbVCVAcI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:32:08 -0500
Subject: Re: Problem with 2.6.11-bk[3456]
From: Andrew Clayton <andrew@digital-domain.net>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050321162638.2bd53b17.akpm@osdl.org>
References: <1110492499.2666.8.camel@alpha.digital-domain.net>
	 <20050321162638.2bd53b17.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 00:32:05 +0000
Message-Id: <1111451525.2768.2.camel@alpha.digital-domain.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-21 at 16:26 -0800, Andrew Morton wrote:
> Andrew Clayton <andrew@digital-domain.net> wrote:
> >
> > Hi,
> > 
> > Got a problem here with the last few Linus -bk releases.
> > 
> > 2.6.11-bk2 is running fine.
> > 
> > 2.6.11-bk3 - 2.6.11-bk6 has the following problem:
> 
> We had a bit of an AGP disaster between -bk2 and -bk3.  There's an
> in-progress fix in 2.6.12-rc1-mm1.  Are you able to test that?
> 

Yeah, I did.

The machine still locked up as soon as X started.

I'll happily test any patches there may be...

[snip]


Cheers,

Andrew

