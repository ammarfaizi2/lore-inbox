Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132425AbRDFWeM>; Fri, 6 Apr 2001 18:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132426AbRDFWeD>; Fri, 6 Apr 2001 18:34:03 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:7720 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S132425AbRDFWdy>; Fri, 6 Apr 2001 18:33:54 -0400
Date: Fri, 6 Apr 2001 17:33:25 -0500
From: Nathan Straz <nstraz@sgi.com>
To: "Timothy D. Witham" <wookie@osdlab.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux Test Project <ltp@oss.sgi.com>
Subject: Re: a quest for a better scheduler
Message-ID: <20010406173324.A27017@sgi.com>
Mail-Followup-To: "Timothy D. Witham" <wookie@osdlab.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linux Test Project <ltp@oss.sgi.com>
In-Reply-To: <20010404151632.A2144@kochanski> <18230000.986424894@hellman> <20010405153841.A2452@osdlab.org> <20010406110603.A1599@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010406110603.A1599@osdlab.org>; from wookie@osdlab.org on Fri, Apr 06, 2001 at 11:06:03AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2001 at 11:06:03AM -0700, Timothy D. Witham wrote:
> Timothy D. Witham wrote :
> > I propose that we work on setting up a straight forward test harness   
> > that allows developers to quickly test a kernel patch against 
> > various performance yardsticks.

The Linux Test Project would like to help out here.  At the least, we
would like to add the scripts, wrappers, and configuration files used to
create the test systems to LTP.  Making test systems available is
definitely a great step forward.  Showing people how to build similar
test systems is another step forward.  

Let us know what parts you need and we'll see what we can come up with.

> Further comments?  I will start contacting folks who have expressed
> interest.

If anyone has loose programs that they use to test the scheduler, please
submit them to the Linux Test Project.  Chances are other people will
also find them useful and add functionality.  It doesn't have to be a
formal test program or use the test libraries that we use.  We can take
care of that when we add it to the CVS tree.

While we probably aren't going to package up full applications for
testing purposes, we could definitely keep track of useful configuration
files and scripts that people find useful for testing.  

-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                    http://oss.sgi.com/projects/ltp/
