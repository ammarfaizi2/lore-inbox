Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUFZMFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUFZMFb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 08:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUFZMFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 08:05:31 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:23567 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S267164AbUFZMF0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 08:05:26 -0400
Date: Sat, 26 Jun 2004 14:07:38 +0200
To: Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: alienware hardware - memory problem?
Message-ID: <20040626120738.GB14609@hh.idb.hist.no>
References: <20040624191026.GP728@washoe.rutgers.edu> <200406242315.56213.vda@port.imtp.ilyichevsk.odessa.ua> <20040624202626.GS728@washoe.rutgers.edu> <200406242358.55782.vda@port.imtp.ilyichevsk.odessa.ua> <20040624212600.GW728@washoe.rutgers.edu> <20040624215856.GA728@washoe.rutgers.edu> <20040625000102.GI728@washoe.rutgers.edu> <40DBE853.4050707@hist.no> <20040625162016.GD16916@washoe.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040625162016.GD16916@washoe.rutgers.edu>
User-Agent: Mutt/1.5.6+20040523i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 12:20:16PM -0400, Yaroslav Halchenko wrote:
> He hey - you're the boss!!!! 
> It helped - 'mem=512M' made the beast fast :-)
> 
> Now we just will mangle with /proc/mtrr :-)
> 
> THANX AGAIN!
> 
Glad to be of help.  I hope the /proc/mtrr stuff works out, it is
nice to use _all_ the memory?.  How much is it?

Don't forget the complaint to the vendor.  The only way to get 
permanently rid of this sort of problem is when the vendors get
enough reactions to sloppy bioses.  Don't be silent just because
you found a solution, you shouldn't really have to in this case.

Also check if there is a newer BIOS around. :-)

Helge Hafting

