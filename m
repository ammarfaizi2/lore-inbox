Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbTF1Q06 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 12:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbTF1Q06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 12:26:58 -0400
Received: from granite.he.net ([216.218.226.66]:3088 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265279AbTF1Q05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 12:26:57 -0400
Date: Sat, 28 Jun 2003 09:28:19 -0700
From: Greg KH <greg@kroah.com>
To: "Sam (Uli) Freed" <spam@freed.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB serial OOPS
Message-ID: <20030628162819.GA1546@kroah.com>
References: <3EFCAF3D.9060207@freed.net> <20030627225144.GC11296@kroah.com> <3EFD3800.4080107@freed.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EFD3800.4080107@freed.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 09:38:56AM +0300, Sam (Uli) Freed wrote:
> Hi all + Greg,
> 
> I have a laptop with a "USB Socking station" attached (basically a 
> hub+serial+paralel.).
> 
> I have managed to use the Serial ONCE to sync my PalmPilot, out of at 
> least 60 attempts. 2-3 of these attempts ended in an OOPS, and here it 
> is in a neat "tar cvzf" format. The only caveat is that is went through 
> an "apm -s" cycle between the oops and the report.

Can you not compress these files next time?  It's real hard to read them
this way.  Large text emails are no problem.

Anyway, can you try this with 2.5?  I think the bug is fixed there but
it would be nice to verify.

thanks,

greg k-h
