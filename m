Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbTBXH5S>; Mon, 24 Feb 2003 02:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbTBXH5S>; Mon, 24 Feb 2003 02:57:18 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:47368 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265039AbTBXH5R>; Mon, 24 Feb 2003 02:57:17 -0500
Date: Mon, 24 Feb 2003 08:07:05 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Larry McVoy <lm@work.bitmover.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Bill Davidsen <davidsen@tmr.com>, lse-tech@lists.sf.et,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224080704.A30910@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Larry McVoy <lm@work.bitmover.com>, Gerrit Huizenga <gh@us.ibm.com>,
	Bill Davidsen <davidsen@tmr.com>, lse-tech@lists.sf.et,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1030223181400.999D-100000@gatekeeper.tmr.com> <E18n9Kx-0000kA-00@w-gerrit2> <20030224040246.GA4215@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030224040246.GA4215@work.bitmover.com>; from lm@bitmover.com on Sun, Feb 23, 2003 at 08:02:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 08:02:46PM -0800, Larry McVoy wrote:
> On Sun, Feb 23, 2003 at 07:31:26PM -0800, Gerrit Huizenga wrote:
> > But most
> > people don't connect big machines to IDE drive subsystems.
> 
> 3ware controllers.  They look like SCSI to the host, but use cheap IDE
> drives on the back end.  Really nice cards.  bkbits.net runs on one.

That's true (similar for some nice scsi2ide external raid boxens), but Alan's
original argument was about the Linux IDE driver on bix machines which is used
by neither..

