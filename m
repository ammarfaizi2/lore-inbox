Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263567AbUE1Pgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbUE1Pgj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 11:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUE1Pgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 11:36:38 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:51173 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263567AbUE1Pgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 11:36:36 -0400
Date: Fri, 28 May 2004 16:35:17 +0100
From: Dave Jones <davej@redhat.com>
To: Larry McVoy <lm@work.bitmover.com>, "Theodore Ts'o" <tytso@mit.edu>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040528153517.GZ22630@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Larry McVoy <lm@work.bitmover.com>, Theodore Ts'o <tytso@mit.edu>,
	"La Monte H.P. Yarroll" <piggy@timesys.com>,
	Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20040527062002.GA20872@work.bitmover.com> <20040527010409.66e76397.akpm@osdl.org> <40B6591C.80901@timesys.com> <20040527214638.GA18349@thunk.org> <20040528132436.GA11497@work.bitmover.com> <20040528150740.GF18449@thunk.org> <20040528151919.GC11265@redhat.com> <20040528152730.GB15718@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528152730.GB15718@work.bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 08:27:30AM -0700, Larry McVoy wrote:
 > > bk revtool $filename
 > > ctrl-c in the gui that pops up
 > 
 > That's just "c", Ctrl-c just happens to work and is not supported.  And
 > "c" is a very funny listing, it's rare that that is what you want.
 > I suspect what you want is to click the last node and then hit "a".

Ah, I found this by accident 8-)

 > > click line that looks interesting - jumps to the cset with
 > > commit comments.
 > double click.
 
ah, for full comments, yes.

		Dave

