Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293533AbSCGHOo>; Thu, 7 Mar 2002 02:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293536AbSCGHOh>; Thu, 7 Mar 2002 02:14:37 -0500
Received: from ns0.auctionwatch.com ([66.7.130.2]:41733 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id <S293533AbSCGHOV>; Thu, 7 Mar 2002 02:14:21 -0500
Date: Wed, 6 Mar 2002 23:14:20 -0800
From: Petro <petro@auctionwatch.com>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Antwort: Re: Kernel Hangs 2.4.16 on heay io Oracle and Tivolie TSM
Message-ID: <20020307071420.GD11830@auctionwatch.com>
In-Reply-To: <OFE7517866.AA039B23-ONC1256B72.0027B52F@bcs.de> <3C838DA7.4050807@namesys.com> <322850000.1015348003@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <322850000.1015348003@tiny>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 12:06:43PM -0500, Chris Mason wrote:
> On Monday, March 04, 2002 06:07:19 PM +0300 Hans Reiser <reiser@namesys.com> wrote:
> > Wasn't 2.4.16 the known unstable vm release of 2.4?  Why do you go to 
> > such effort to stick with a bad kernel?  Go to 2.4.18.
> I'm not sure exactly which vm problems you mean, but He's running the 
> suse 2.4.16, which is heavily patched. When your running big production
> databases, upgrading to the kernel of the week isn't an option.
> I think we've found the bug, it looks like a race in the proc code.
> Oliver, someone will contact you a little later with instructions on
> getting a kernel with the fix.  If you only see this oops during backups,
> make sure you aren't trying to backup /proc.

    Is this in the generic kernel, or the patches? 

-- 
Share and Enjoy. 
