Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbTCGQXG>; Fri, 7 Mar 2003 11:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261684AbTCGQXG>; Fri, 7 Mar 2003 11:23:06 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:1152 "EHLO bjl1.jlokier.co.uk")
	by vger.kernel.org with ESMTP id <S261683AbTCGQXF>;
	Fri, 7 Mar 2003 11:23:05 -0500
Date: Fri, 7 Mar 2003 16:33:35 +0000
From: Jamie Lokier <jamie@shareable.org>
To: george anzinger <george@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Making it easy to add system calls
Message-ID: <20030307163335.GA5323@bjl1.jlokier.co.uk>
References: <Pine.LNX.4.44.0303051926180.10651-100000@home.transmeta.com> <3E66D77D.4050800@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E66D77D.4050800@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> >Me no likee.
> 
> Cool.  It was just a thought that I could not put down with out doing 
> the code :)

It would be nice to have a single list of non-architecture-specific
system calls though.  Think of the number of times a system call has
been added to many architectures but left out, quite by accident, of
one or two until someone notices.

--  Jamie
