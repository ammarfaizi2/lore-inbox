Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272661AbRIMBrv>; Wed, 12 Sep 2001 21:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272666AbRIMBrl>; Wed, 12 Sep 2001 21:47:41 -0400
Received: from [208.48.139.185] ([208.48.139.185]:2944 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S272661AbRIMBrb>; Wed, 12 Sep 2001 21:47:31 -0400
Date: Wed, 12 Sep 2001 18:47:47 -0700
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.9
Message-ID: <20010912184747.A883@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B991346.7393E7AF@zip.com.au> <20010908045952.P7672@emma1.emma.line.org> <999921805.903.6.camel@phantasy> <20010912183949.G25683@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010912183949.G25683@mikef-linux.matchmail.com>; from mfedyk@matchmail.com on Wed, Sep 12, 2001 at 06:39:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2001 at 06:39:49PM -0700, Mike Fedyk wrote:
> On Sat, Sep 08, 2001 at 12:03:24AM -0400, Robert Love wrote:
> > I went ahead and rediffed ext3-0.9.9 against 2.4.9-ac10.  Find it
> > attached (65k, 17k gzipped).
> > 
> > Ted's ext3 directory speedup still applies cleanly, of course.
> > 
> > Still using ext3-0.9.9 + dir speed up, now on ac10, with no problems.
> > 
> 
> Can someone point me to that dir speed up patch?  I've looked on kernel
> newbies for Tso's page, google searches found old dev archives for ext2, and
> a patch against 2.4.4 for directory indexing....
> 
> Is there anything I should know before trying this?

You can download it at the ext3 for 2.4 page:

http://www.uow.edu.au/~andrewm/linux/ext3/

Only thing you should know is that it hasn't been that heavily tested on
ext3.

-Dave
