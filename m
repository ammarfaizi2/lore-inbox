Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbTIXJAK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 05:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTIXJAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 05:00:10 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:38320 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261268AbTIXJAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 05:00:06 -0400
Date: Wed, 24 Sep 2003 10:59:58 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: ATTACK TO MY SYSTEM
Message-ID: <20030924085958.GB1355@wohnheim.fh-wedel.de>
References: <200309240740.h8O7eZNI000474@81-2-122-30.bradfords.org.uk> <20030924084616.GA16727@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030924084616.GA16727@alpha.home.local>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 September 2003 10:46:16 +0200, Willy Tarreau wrote:
> On Wed, Sep 24, 2003 at 08:40:35AM +0100, John Bradford wrote:
>  
> > RFC 822, section 3.4.7, makes clear that case is _not_ significant for
> > these field names.  RFC 2822 doesn't change this.
> 
> Sorry John about the mis-information. Of course case is not significant,
> otherwise we would simply not receive these mails. I should have said
> "common usage" and not "protocols", since I really thought the former
> eventhough I wrote the later.
> 
> > Just because no commonly used E-Mail application seems to generate
> > uppercase field names, how do you know something like a password
> > auto-responder script won't?
> 
> I don't know. It's only an empirical choice based on observations. Many of us
> are more concerned by hundreds of mails a day than risking to get a rare
> false-positive. But I agree, I should have been clearer.
> 
> I have nearly the same .procmailrc as the one Joern Engel proposed :
> 
>   :0 D
>   * ^FORM:
>   spam/swen
> 
> And I too agree that I have 0% false positive so far. But just like any filter,
> use at your own risk...

All right, let's do this on-list *once* before the already off-topic
thread spreads too far.

o Filtering by all-uppercase subject, etc. if effective for swen.
o This filter has produces 0% false positives *so far*.
o This filter, just like any filter, can produce false positives.
o Anyone using filters without checking for false positives it at his
  and her own mercy.  Tough luck, deal with it.

EOT.

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu
