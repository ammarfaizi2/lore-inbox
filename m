Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266108AbSLSUZS>; Thu, 19 Dec 2002 15:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbSLSUZS>; Thu, 19 Dec 2002 15:25:18 -0500
Received: from gbmail.gettysburg.edu ([138.234.4.100]:21735 "EHLO
	gettysburg.edu") by vger.kernel.org with ESMTP id <S266108AbSLSUZR>;
	Thu, 19 Dec 2002 15:25:17 -0500
Date: Thu, 19 Dec 2002 15:33:04 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Dedicated kernel bug database
Message-ID: <20021219203304.GA9135@perseus.homeunix.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <2CC936747EA1284DA378A18D730697420158A50E@exchacad.ms.gettysburg.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2CC936747EA1284DA378A18D730697420158A50E@exchacad.ms.gettysburg.edu>
User-Agent: Mutt/1.4i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 01:53:29PM -0500, Dave Jones wrote:
> On Thu, Dec 19, 2002 at 11:48:16AM -0600, Eli Carter wrote:
>  > >Also, we could have a non-web interface, (telnet or gopher to the bug
>  > >DB, or control it by E-Mail).
> 
> It's an annoyance to me that the current bugzilla we use can only
> 
> Its a nice idea, but I think it's a lot of effort to get it right,
> when a human can look at the dump, realise its not decoded, and

I can't say I'm partial to bugzilla either; the reasons above are valid.
I think it could be very useful to have a bugtracking system written by
someone@kernel.org (or at least have someone@kernel.org who is intimitely
familiar with the bugtracking code).  The above dislikes of bugzilla are
all fixable, and it may be easier for someone to do it from scratch than
to try to decode someone else's messy code (I wonder if there is a
bugzilla for bugzilla bugs).

Many of the complaints about current postings, however, could possibly
be fixed by nicifying the kernel webpages (many people don't know much
about ``distribution kernels,'' and might happily try other kernels if
they knew how).

Another part of the problem is that there is no _official_ way of
submitting bugs.  Were someone official to say ``all bugs go to bugzilla,''
(or kzilla, as the case may be), there would certainly be a better
response.  Whatever the current official bugtracking mechanism is, it
should appear on the lkml webpage (atm, it does not).

Justin
