Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTLBQLc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 11:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTLBQLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 11:11:32 -0500
Received: from wsi-204-189.wsi.com ([4.36.204.189]:41344 "EHLO
	nuttfield.wsicorp.com") by vger.kernel.org with ESMTP
	id S262319AbTLBQLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 11:11:16 -0500
Subject: Re: XFS for 2.4
From: Darrell Michaud <dmichaud@wsi.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0312021346530.13692-100000@logos.cnet>
References: <Pine.LNX.4.44.0312021346530.13692-100000@logos.cnet>
Content-Type: text/plain
Organization: 
Message-Id: <1070381443.5316.260.camel@atherne>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 02 Dec 2003 11:10:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a user it would be very beneficial for me to have XFS support in the
official 2.4 kernel tree. XFS been stable and "2.4 integration-ready"
for a long time, and 2.4 is going to be used in certain environments for
a long time, if only because it's easier to upgrade a 2.4 kernel to a
newer 2.4 kernel than to upgrade to a 2.6 kernel. It seems like an easy
case to make.

I use other filesystems and some funky drivers as well.. and I'm always
very happy to see useful backports show up in the 2.4 tree. Thank you!



On Tue, 2003-12-02 at 10:50, Marcelo Tosatti wrote:
> On Tue, 2 Dec 2003, Russell Cattelan wrote:
> 
> > On Tue, 2003-12-02 at 05:18, Marcelo Tosatti wrote:
> > [snip] 
> > > Also I'm not completly sure if the generic changes are fine and I dont
> > > like the XFS code in general.
> > Ahh so the real truth comes out.
> > 
> > 
> > Is there a reason for your sudden dislike of the XFS code?
> 
> I always disliked the XFS code. 
> 
> > or is this just an arbitrary general dislike for unknown or unstated
> > reasons?
> 
> I dont like the style of the code. Thats a personal issue, though, and 
> shouldnt matter.
> 
> The bigger point is that XFS touches generic code and I'm not sure if that 
> can break something.
> 
> Why it matters so much for you to have XFS in 2.4 ? 
> 
-- 
Darrell Michaud <dmichaud@wsi.com>

