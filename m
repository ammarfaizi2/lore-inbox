Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261892AbTCGXo4>; Fri, 7 Mar 2003 18:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261891AbTCGXo4>; Fri, 7 Mar 2003 18:44:56 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:59328 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261892AbTCGXoh>; Fri, 7 Mar 2003 18:44:37 -0500
Date: Fri, 7 Mar 2003 23:52:47 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Those ruddy punctuation fixes
Message-ID: <20030308005241.GA24077@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3E684737.7080704@kegel.com> <20030307121723.B3204@redhat.com> <1047078959.23697.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047078959.23697.12.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 11:15:59PM +0000, Alan Cox wrote:

 > > Spelling fixes are annoying ways to break patches that provide no 
 > > user visible value.  It also detracts from the character of the 
 > > code: who wants "drain brammage" to be replaced with "brain dammage"?
 > People are actually *doing* things, give them a break.

There's a shitload of patches in the 2.4 commit archives that
mostly still apply. With each iteration of spelling fixes,
it becomes more and more work to weed through these to find
out if things are really applied or not.  In the beginning I
used Rusty's 'isapplied' script. Its now pretty much useless,
requiring manual inspection of code on every diff.

Spelling fixes aren't going to get us to 2.6.0 any faster.
There are _dozens_ of known problems, and I'll take patches
fixing real problems over spelling fixes any day.

		Dave

