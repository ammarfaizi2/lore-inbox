Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285552AbSADNFs>; Fri, 4 Jan 2002 08:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286334AbSADNF3>; Fri, 4 Jan 2002 08:05:29 -0500
Received: from ns.ithnet.com ([217.64.64.10]:5642 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S285552AbSADNFZ>;
	Fri, 4 Jan 2002 08:05:25 -0500
Date: Fri, 4 Jan 2002 14:05:18 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: brownfld@irridia.com, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-Id: <20020104140518.1278da58.skraw@ithnet.com>
In-Reply-To: <20020104100604.D1331@niksula.cs.hut.fi>
In-Reply-To: <20020103142301.C4759@asooo.flowerfire.com>
	<200201040019.BAA30736@webserver.ithnet.com>
	<20020103232601.B12884@asooo.flowerfire.com>
	<20020104100604.D1331@niksula.cs.hut.fi>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002 10:06:05 +0200
Ville Herva <vherva@niksula.hut.fi> wrote:

> On Thu, Jan 03, 2002 at 11:26:01PM -0600, you [Ken Brownfield] claimed:
> > 
> > | > 3) Memory allocation failures and OOM triggers                      
> > | >    even though caches remain full.                                  
> > |                                                                       
> > | I have not had one up to now in everyday life with 2.4.17             
> > 
> > I'm seeing this in malloc()-heavy apps, but fairly sporadic unless I
> > create a test case.  
> 
> I'm seeing this on 2GB IA64 (2.4.16-17). I posted a _very_ simple test case
> to lkml a while a go. It didn't happen on 256MB x86.
> 
> I plan to try -aa shortly, now that I got patches to make it compile on
> IA64.

Ok, I am going to buy more mem right now to see what you see.

Regards,
Stephan


