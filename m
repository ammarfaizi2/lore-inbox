Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTLBQYd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 11:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTLBQYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 11:24:33 -0500
Received: from host-65-120-145-91.coremetrics.com ([65.120.145.91]:60343 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262352AbTLBQYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 11:24:30 -0500
Subject: Re: XFS for 2.4
From: Austin Gonyou <austin@coremetrics.com>
To: Darrell Michaud <dmichaud@wsi.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, XFS List <linux-xfs@oss.sgi.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1070381443.5316.260.camel@atherne>
References: <1070381443.5316.260.camel@atherne>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Coremetrics, Inc.
Message-Id: <1070382114.2392.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Dec 2003 10:21:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I second this as well. I'm sure there are others. XFS is a good option
to have for official FS inclusion and I'm *very* happy it's in 2.6. If
it were in 2.4, that *may* make adoption of 2.6 for some, slow in coming
along. While that may be true, I see that most will eventually want to
take advantage of all 2.6 has to offer, but if XFS were in the official
tree, then that may be one less piece of guess work needed when
upgrading from 2.4 to 2.6 with regards to FS maintenance. (i.e. same
version of XFS in both trees == possible same reliability, etc)

On Tue, 2003-12-02 at 10:10, Darrell Michaud wrote:
> As a user it would be very beneficial for me to have XFS support in
> the
> official 2.4 kernel tree. XFS been stable and "2.4 integration-ready"
> for a long time, and 2.4 is going to be used in certain environments
> for
> a long time, if only because it's easier to upgrade a 2.4 kernel to a
> newer 2.4 kernel than to upgrade to a 2.6 kernel. It seems like an
> easy
> case to make.
> 
> I use other filesystems and some funky drivers as well.. and I'm
> always
> very happy to see useful backports show up in the 2.4 tree. Thank you!
> 
> 
> 
> On Tue, 2003-12-02 at 10:50, Marcelo Tosatti wrote:
> > On Tue, 2 Dec 2003, Russell Cattelan wrote:
> > 
> > > On Tue, 2003-12-02 at 05:18, Marcelo Tosatti wrote:
> > > [snip] 
> > > > Also I'm not completly sure if the generic changes are fine and
> I dont
> > > > like the XFS code in general.
> > > Ahh so the real truth comes out.
> > > 
> > > 
> > > Is there a reason for your sudden dislike of the XFS code?
> > 
> > I always disliked the XFS code. 
> > 
> > > or is this just an arbitrary general dislike for unknown or
> unstated
> > > reasons?
> > 
> > I dont like the style of the code. Thats a personal issue, though,
> and 
> > shouldnt matter.
> > 
> > The bigger point is that XFS touches generic code and I'm not sure
> if that 
> > can break something.
> > 
> > Why it matters so much for you to have XFS in 2.4 ? 
> > 
> -- 
> Darrell Michaud <dmichaud@wsi.com>
-- 
Austin Gonyou <austin@coremetrics.com>
Coremetrics, Inc.
