Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264532AbTKNRIY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbTKNRFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:05:54 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:6563 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264518AbTKNREv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:04:51 -0500
Date: Fri, 14 Nov 2003 09:04:49 -0800
From: Larry McVoy <lm@bitmover.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031114170449.GA32466@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031114164844.GB1618@work.bitmover.com> <Pine.LNX.4.44.0311140856390.1827-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311140856390.1827-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 09:03:05AM -0800, Davide Libenzi wrote:
> On Fri, 14 Nov 2003, Larry McVoy wrote:
> 
> > update, yes.  history, no, use bk/web.  diffs, no, use bk/web or bk.  building
> > it is certainly possible and you could do it yourself.  We already built the
> > cvs exporter which is a lot nicer than what you are asking for and building 
> > another thing for another 6 users seems pointless.  If you want to pay for the
> > engineering then contact me offline.
> 
> I want nothing new. A BK with only the CVS exporter that you already have 
> will work plain fine. We do not need even 25 exports formats. Once we 
> have your existing binary that does:
> 
> bk2cvs remote-bkrepo local-cvs-repo
> 
> would be great. All other export can be based from that with local 
> scripts. With a little bit less restrictive license, Is it something 
> painful for BM to do?

Yes.  bk2cvs is not a supported product, and it is based on the commercial
only version of BK.  We're not giving that out for free.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
