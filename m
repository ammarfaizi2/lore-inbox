Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143876AbRA1UNt>; Sun, 28 Jan 2001 15:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143907AbRA1UNl>; Sun, 28 Jan 2001 15:13:41 -0500
Received: from [63.95.87.168] ([63.95.87.168]:37644 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S143880AbRA1UNg>;
	Sun, 28 Jan 2001 15:13:36 -0500
Date: Sun, 28 Jan 2001 15:13:32 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: James Sutherland <jas88@cam.ac.uk>
Cc: jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
Message-ID: <20010128151332.F13195@xi.linuxpower.cx>
In-Reply-To: <Pine.GSO.4.30.0101281039440.24762-100000@shell.cyberus.ca> <Pine.SOL.4.21.0101281704430.16734-100000@green.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <Pine.SOL.4.21.0101281704430.16734-100000@green.csi.cam.ac.uk>; from jas88@cam.ac.uk on Sun, Jan 28, 2001 at 05:11:20PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 05:11:20PM +0000, James Sutherland wrote:
[snip]
> > The simplest thing in this chaos is to fix the firewall because it is in
> > violation to begin with.
> 
> It is not in violation, and you can't fix it: it's not yours.
[snip]
 > > It's too bad we end up defining protocols using English. We should use
> > mathematical equations to remove any ambiguity ;->
> 
> No, just use English properly. "Must be zero" doesn't actually mean "must
> be set to zero when sending, and ignored when receiving/processing", which
> is probably what the standard SHOULD have said.

I see your problem now... You can't read!
The standard don't just say "Must be zero" it also says that it is reserved.
Reserved is very explicitly defined elseware... In the language of RFCs (and
most of engineering) it means 'you must always set it as specified' when
generating, and you must never behave differently because of it. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
