Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261818AbTCLRcN>; Wed, 12 Mar 2003 12:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbTCLRcN>; Wed, 12 Mar 2003 12:32:13 -0500
Received: from bitmover.com ([192.132.92.2]:2213 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261818AbTCLRcL>;
	Wed, 12 Mar 2003 12:32:11 -0500
Date: Wed, 12 Mar 2003 09:42:44 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312174244.GC13792@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[BK is locking up our data]
[BitMover has to give us our data in an open format]
[The BK pill is oh-so-bitter]
[My tummy hurts and it's Larry's fault]

Boo hoo, cry me a river.

Those of you complaining ought to at least look before you complain.
You just assumed that we were screwing you and you couldn't be bothered
to verify it before you complained.  We didn't screw you at all, all
the data is there.  And BK itself has always had the ability to export
any data in any format, if you read the man pages you might notice that,
but that would be too much work, it's easier to complain.

If you had actually gone and looked at the CVS repository you would have
seen that there is nothing of value missing, in almost 100% of the files,
the full revision history is preserved:

	CVS: 110,076 deltas over all files
	BK:  121,891 deltas over all files

You guys don't have that much parallelism in your files and the exporter
is capturing all that it can which is virtually everything.  It's worth
noting that many deltas in BK are just event recorders, they are just
empty merge delta noise and in fact many people have asked us to get rid
of them.  Once again, it's easier to complain than think.  I'm detecting
a trend.

The graph traversal managed to capture an amazing amount of information,
it's bloody awesome, which you might have noticed if you had looked.
But, nooooo, let's just piss and moan.  What a bunch of friggin' whiners.

The next time you open your mouth, the words that come out of it should be
"thank you".  Nothing else, just that.  If you can't say something nice,
now is a good time to say nothing at all because we are sick and tired of
dealing with people who complain far more than they code.  I'm serious,
we've done way more than anyone could reasonably expect and you react
with no basis in fact, assume bad things that aren't true, don't bother
to look to see if there is a real problem, and don't bother to say thanks.
Aren't you the slightest bit ashamed of your behaviour?  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
