Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272651AbRIMBju>; Wed, 12 Sep 2001 21:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272661AbRIMBjl>; Wed, 12 Sep 2001 21:39:41 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:45820
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S272651AbRIMBjc>; Wed, 12 Sep 2001 21:39:32 -0400
Date: Wed, 12 Sep 2001 18:39:49 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.9
Message-ID: <20010912183949.G25683@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3B991346.7393E7AF@zip.com.au> <20010908045952.P7672@emma1.emma.line.org> <999921805.903.6.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <999921805.903.6.camel@phantasy>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2001 at 12:03:24AM -0400, Robert Love wrote:
> I went ahead and rediffed ext3-0.9.9 against 2.4.9-ac10.  Find it
> attached (65k, 17k gzipped).
> 
> Ted's ext3 directory speedup still applies cleanly, of course.
> 
> Still using ext3-0.9.9 + dir speed up, now on ac10, with no problems.
> 

Can someone point me to that dir speed up patch?  I've looked on kernel
newbies for Tso's page, google searches found old dev archives for ext2, and
a patch against 2.4.4 for directory indexing....

Is there anything I should know before trying this?

Mike
