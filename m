Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290792AbSBOUnO>; Fri, 15 Feb 2002 15:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290796AbSBOUnE>; Fri, 15 Feb 2002 15:43:04 -0500
Received: from bitmover.com ([192.132.92.2]:43405 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290793AbSBOUmz>;
	Fri, 15 Feb 2002 15:42:55 -0500
Date: Fri, 15 Feb 2002 12:42:55 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020215124255.F28735@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215135557.B10961@thyrsus.com> <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020215145421.A12540@thyrsus.com>; from esr@thyrsus.com on Fri, Feb 15, 2002 at 02:54:21PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 02:54:21PM -0500, Eric S. Raymond wrote:
> Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>:
> > > But I think you know very well that the usual flow looks like this:
> > > 
> > > 1. You throw a patch over the wall to Linus.
> > > 
> > > 2. Either it shows up in the next release...
> > > 
> > > 3. ...or you hear a vast and echoing silence.
> > 
> > You're telling me Linus never mailed you about splitting up Configure.help ?
> 
> That's right.  

Gimme a break.  I read those posts, I repeatedly saw that people said to do 
that, I don't remember if it was Linus or not, but it's not like he has the
only brain.  The clearly expressed sentiment was to put the help next to the
source.  You repeatedly came up with corner cases where that wouldn't work
and used that as an excuse to do nothing.  Having just gone through the same
thing with Linus about BK locking, I can assure you that dredging up the
corner cases does not work, you might as well get to work and solve the 
problem.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
