Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317909AbSGWBrQ>; Mon, 22 Jul 2002 21:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317910AbSGWBrQ>; Mon, 22 Jul 2002 21:47:16 -0400
Received: from ns.suse.de ([213.95.15.193]:40204 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317909AbSGWBrP>;
	Mon, 22 Jul 2002 21:47:15 -0400
Date: Mon, 22 Jul 2002 23:31:19 +0200
From: Dave Jones <davej@suse.de>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       Rik van Riel <riel@conectiva.com.br>
Subject: Re: bug database/webpage
Message-ID: <20020722233119.R27749@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	Rik van Riel <riel@conectiva.com.br>
References: <Pine.LNX.4.44.0207221547360.19736-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207221547360.19736-100000@dad.molina>; from tmolina@cox.net on Mon, Jul 22, 2002 at 03:59:01PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 03:59:01PM -0500, Thomas Molina wrote:
 > 
 > In a conversation with Guillaume Boissiere it was mentioned that setting 
 > up a bug/problem report database for later in the 2.5 development cycle.  
 > Cox won't let me run an Apache web server from home with a bugzilla-type 
 > database (my preference), but I have been playing around with a simplistic 
 > web page problem report tracking available at 
 > http://members.cox.net/tmolina
 > 
 > Would something like this be sufficient, or would a full-fledged server be 
 > required?  Feedback/comments are welcome

Quite nice. It's a more organised version of what I had, but as the
number of reports gets higher and higher, it could end up being as much a
maintainence nightmare as the log I was updating.

Talking with a few folks about this problem at the summit, a few times
jitterbug was mentioned. My faded memory doesn't recall too much about
those days, but ultimatly it didn't work out.

I'm wondering how such a system would work out today.
There's even possibilites for neat things like checking
bitkeeper to automatically update status when Linus applies
a patch, which before required interaction from Linus.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
