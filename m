Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbTKNRFP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTKNRDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:03:20 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:2445 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262782AbTKNRDF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:03:05 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 14 Nov 2003 09:03:05 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Larry McVoy <lm@bitmover.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <20031114164844.GB1618@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0311140856390.1827-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Nov 2003, Larry McVoy wrote:

> update, yes.  history, no, use bk/web.  diffs, no, use bk/web or bk.  building
> it is certainly possible and you could do it yourself.  We already built the
> cvs exporter which is a lot nicer than what you are asking for and building 
> another thing for another 6 users seems pointless.  If you want to pay for the
> engineering then contact me offline.

I want nothing new. A BK with only the CVS exporter that you already have 
will work plain fine. We do not need even 25 exports formats. Once we 
have your existing binary that does:

bk2cvs remote-bkrepo local-cvs-repo

would be great. All other export can be based from that with local 
scripts. With a little bit less restrictive license, Is it something 
painful for BM to do?



- Davide


