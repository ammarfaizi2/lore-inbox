Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbUBWNv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbUBWNv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:51:57 -0500
Received: from foo.ardendo.se ([212.32.189.9]:32009 "EHLO foo.ardendo.se")
	by vger.kernel.org with ESMTP id S261860AbUBWNu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:50:28 -0500
Subject: Re: Filesystem kernel hangup, 2.6.3 (bad: scheduling while atomic!)
From: Mikael Wahlberg <mikael.wahlberg@ardendo.se>
To: Seth Mos <knuffie@xs4all.nl>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, Per Lejontand <pele@ardendo.se>,
       Jonas =?ISO-8859-1?Q?Engstr=F6m?= <jonas@ardendo.se>
In-Reply-To: <4.3.2.7.2.20040223144245.01c2e688@pop.xs4all.nl>
References: <20040223121959.A8354@infradead.org>
	 <20040222164941.D6046@foo.ardendo.se> <20040223121959.A8354@infradead.org>
	 <4.3.2.7.2.20040223144245.01c2e688@pop.xs4all.nl>
Content-Type: text/plain
Organization: Ardendo
Message-Id: <1077544223.1247.23.camel@harrier>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 23 Feb 2004 14:50:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-23 at 14:46, Seth Mos wrote:
> At 14:08 23-2-2004 +0100, Mikael Wahlberg wrote:
> >On Mon, 2004-02-23 at 13:19, Christoph Hellwig wrote:
> > > On Sun, Feb 22, 2004 at 04:49:41PM +0100, Mikael Wahlberg wrote:
> > > did you run memtest86 on the box?  do you some strange patches applied or
> > > external modules loaded?  What's your .config?
> >
> >No strange patches. Pure 2.6.3 dist kernel. We haven't run memtest86,
> >but as I mentioned above, we have 4 equal machines with error correcting
> >memory, so I find it unlikely to be a memory problem.
> 
> The memory might be fine, but the mainboard might still be borked. I have 
> seen this once with Dell kit. Asuming can be dangerous. If you can spare 
> the down time it is always a good idea to make sure.

Yes, but four new identical boxes... seems very unlikely. But sure, we
can try it when I get to the computer room (It is not at our site, but
at a customers)

/Mikael
-- 
-----------------------------------------------------------------------
 Mikael Wahlberg,  M.Sc.                  Ardendo
 Unit Manager Professional Services/      e-mail: mikael@ardendo.se
 Technical Project Manager                GSM:    +46 733 279 274

