Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWJBPsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWJBPsp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWJBPsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:48:45 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:33482 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964820AbWJBPsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:48:45 -0400
Subject: Re: Spam, bogofilter, etc
From: Lee Revell <rlrevell@joe-job.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <45212F39.5000307@mbligh.org>
References: <1159539793.7086.91.camel@mindpipe>
	 <20061002100302.GS16047@mea-ext.zmailer.org>
	 <1159802486.4067.140.camel@mindpipe>  <45212F39.5000307@mbligh.org>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 11:48:57 -0400
Message-Id: <1159804137.4067.144.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 08:24 -0700, Martin J. Bligh wrote:
> > Could a heuristic be added to reject messages with wildly incorrect
> > dates?  I notice that the last 5-10 messages in my LKML folder every
> > morning are spam with a date that's ~24 hours in the future.
> 
> If you got rid of "slut" and "schoolgirl" that'd get rid of half of
> it. 

That will work for a day then they'll just change the spelling.  But
I've seen spammers using incorrect dates (presumably to appear at the
beginning or end of a mailbox) for years.

You could also flag a very short message that contains a URL and is not
a reply to an existing thread - I can't think of a legitimate post to
LKML fitting this pattern.

I would hate to see the list closed as that would amount to surrendering
to the spammers.

Lee

