Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263030AbTCLEp7>; Tue, 11 Mar 2003 23:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263033AbTCLEp7>; Tue, 11 Mar 2003 23:45:59 -0500
Received: from bitmover.com ([192.132.92.2]:39313 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S263030AbTCLEp4>;
	Tue, 11 Mar 2003 23:45:56 -0500
Date: Tue, 11 Mar 2003 20:56:38 -0800
From: Larry McVoy <lm@bitmover.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312045638.GA13291@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20030312034330.GA9324@work.bitmover.com> <b4mdln$cd$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4mdln$cd$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 08:39:19PM -0800, H. Peter Anvin wrote:
> I can only speak for myself, but I didn't mind until the license ended
> up having the "unless you hack on other tools" exception in it.
> Personally, I value my freedom to hack on whatever I want a lot more
> than the convenience of BK.  

Yeah, that's cool, I don't blame you, it's a pretty extreme clause.
We may well drop it in the future if we feel we have pulled far enough
ahead that everyone else is just playing catchup.  I do apologize for
that clause, I know it caused a lot of concern, but try and remember that
I'm "you" in that I'm just an engineer figuring this stuff out as I go.
We try and fix it as we go as well so there is hope.

> Having this capability available will certainly make life better for
> everyone involved.  Besides, "we won't hold your data hostage" is
> actually a pretty nice selling argument.

Yup.  I really thought that all the export stuff was !hostage but I
didn't factor in the license issues.

> > As soon as we have this
> > debugged, I'd like to move the CVS repositories to kernel.org (if I can
> > get HPA to agree) 
> 
> I'm sure we can work something out.  However, at the moment
> zeus.kernel.org, our main server with lots and lots of bandwidth, is
> starting to run into its limits, so I can't promise *when* that will
> happen.  Just putting in another server 

We can certainly pay for a server, a server is not that much money and
is not an ongoing cost.  So if that's the problem, I can get you a server
in less than a week, ping me off line and we'll work it out.

The main thing is that the CVS server and the tarball of the CVS repository
are *not* under our control.  That's the only way some people are going to
believe that we're not out to screw them and it would oh-so-nice to have
people think that, it really would.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
