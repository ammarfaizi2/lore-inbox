Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286280AbRLTPzs>; Thu, 20 Dec 2001 10:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286281AbRLTPzi>; Thu, 20 Dec 2001 10:55:38 -0500
Received: from rj.sgi.com ([204.94.215.100]:60040 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S286280AbRLTPzY>;
	Thu, 20 Dec 2001 10:55:24 -0500
Date: Thu, 20 Dec 2001 09:55:21 -0600
From: Nathan Straz <nstraz@sgi.com>
To: Dave Jones <davej@suse.de>
Cc: "David S. Miller" <davem@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
Message-ID: <20011220155521.GA31467@sgi.com>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011218.123130.58437921.davem@redhat.com> <Pine.LNX.4.33.0112182134400.29077-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112182134400.29077-100000@Appserv.suse.de>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 09:36:10PM +0100, Dave Jones wrote:
> On Tue, 18 Dec 2001, David S. Miller wrote:
> 
> > BTW, here is a portability fix for fsx-linux.c :-)
> 
> Cool, danke.
> I'll wrap it in an ifdef and push it to the Apple folks
> when I send my next changes.

fsx had been added to the Linux Test Project with permission by Apple.
I've integrated the above change.  Any other changes can be submitted to
the LTP list or as a patch on the LTP project page.  fsx is filed in
ltp/testcases/kernel/fs/fsx-linux.

Thank to everyone how dug this up and polished it off.  
-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                                  http://ltp.sf.net/
