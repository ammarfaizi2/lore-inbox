Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbUKSTVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbUKSTVD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 14:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbUKSTVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 14:21:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:8600 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261541AbUKSTVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 14:21:00 -0500
Date: Fri, 19 Nov 2004 11:20:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Eric Pouech <pouech-eric@wanadoo.fr>
cc: Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <419E42B3.8070901@wanadoo.fr>
Message-ID: <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <419E42B3.8070901@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Nov 2004, Eric Pouech wrote:
> 
> the first patch put in BK by Linus doesn't fix the problem. Any plan to fix the 
> two other spots Roland mentionned ?

Can you just try it? I don't have wine, and since my main machine is 
ppc64, and I don't actually have any windows programs to test even on any 
of my laptops...

		Linus
