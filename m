Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263660AbTKFP4z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 10:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263675AbTKFP4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 10:56:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:50594 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263660AbTKFP4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 10:56:54 -0500
Date: Thu, 6 Nov 2003 07:56:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: bert hubert <ahu@ds9a.nl>
cc: Scott Robert Ladd <coyote@coyotegulch.com>, Larry McVoy <lm@bitmover.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BK2CVS problem
In-Reply-To: <20031106100606.GA23891@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0311060751170.1842-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Nov 2003, bert hubert wrote:
> 
> And, was there any route via which this malicious patch could've worked
> itself into a kernel release?

No. There are two ways to get into a kernel release: patches to me by
email (which depending on the person get more or less detailed scrutiny,
but core files would definitely get a read-through and need an
explanation), and through BK merges.

And the people who merge with BK wouldn't have used the CVS tree. 

		Linus

