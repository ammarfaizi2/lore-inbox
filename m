Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVCCV6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVCCV6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVCCVyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:54:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62684 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262619AbVCCVw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:52:56 -0500
Date: Thu, 3 Mar 2005 16:52:45 -0500
From: Dave Jones <davej@redhat.com>
To: John Cherry <cherry@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       jgarzik@pobox.com, rmk+lkml@arm.linux.org.uk,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303215245.GK29371@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	John Cherry <cherry@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, jgarzik@pobox.com,
	rmk+lkml@arm.linux.org.uk,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050303052100.GA22952@redhat.com> <1109886590.24056.33.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109886590.24056.33.camel@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 01:49:50PM -0800, John Cherry wrote:
 > On Thu, 2005-03-03 at 00:21 -0500, Dave Jones wrote:
 > <snip>
 > > compile time regressions we should be able to nail down fairly easily.
 > > (someone from OSDL is already doing compile stats and such on each release
 > >  [too bad they're mostly incomprehensible to the casual viewer])
 > 
 > Dave, I'm the "someone from OSDL".  I agree that the compile stats and
 > error/warning regresssions can be a little challenging to grock for the
 > casual observer.  Is it content or formatting that would help the casual
 > viewer?

I don't have one handy to quote from, but personally I find there
are two problems with what's currently presented.

1 - information overload. It's just a screenfull of numbers.
2 - the column headings were non-obvious iirc. Or maybe I'm just dumb
    and didn't look at them long enough.

So it could just need some formatting tweaks to make it more
palatable.

		Dave

