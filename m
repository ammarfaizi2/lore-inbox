Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbVITIbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbVITIbV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbVITIbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:31:21 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:11964 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964910AbVITIbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:31:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=PiVS96T7u6YC9eGSEnAY1FQtQEAA41kH4A1hxI2pZ5k6PjmOrYgNr1SKmNCukwKCTTj732e7DXJg6GFPnJjkpAnJhToBUwV4f2Y9rVdph8kXX3Gok8RWY0l4WbO5YnFQ6OBCTXEnkMf9xmwBHNxpEuyt2wJBn4W50wKJ5BzXuJc=  ;
Subject: elevators (was Re: I request inclusion of reiser4 in the mainline
	kernel)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Hans Reiser <reiser@namesys.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Nate Diller <ndiller@namesys.com>
In-Reply-To: <432FC150.9020807@namesys.com>
References: <432AFB44.9060707@namesys.com>
	 <200509171415.50454.vda@ilport.com.ua>
	 <200509180934.50789.chriswhite@gentoo.org>
	 <200509181321.23211.vda@ilport.com.ua>
	 <20050918102658.GB22210@infradead.org>
	 <b14e81f0050918102254146224@mail.gmail.com>
	 <1127079524.8932.21.camel@localhost.localdomain>
	 <432E4786.7010001@namesys.com> <432F8D1E.7060300@yahoo.com.au>
	 <432FABFA.9010406@namesys.com> <1127200590.9436.15.camel@npiggin-nld.site>
	 <432FC150.9020807@namesys.com>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 18:31:02 +1000
Message-Id: <1127205062.9436.38.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC list trimmed.

On Tue, 2005-09-20 at 00:59 -0700, Hans Reiser wrote:
> Nick Piggin wrote:
> 
> >On Mon, 2005-09-19 at 23:28 -0700, Hans Reiser wrote:
> >  
> >

> >Well the terminology changed to "io scheduler" now, however the
> >residual "elevator" name found in places doesn't cause anyone
> >any problems and there isn't much reason to change it other than
> >the desire to break things.
> >  
> >
> Did you really say that?    I mean, come on, can't you at least manage a
> "well, it ought to get changed but I am busy with something more
> exciting to me".
> 

In a perfect world maybe it should be changed, however I don't
know what out of tree drivers rely on the interface and I really
don't care to find out. Simple as that.

> Ask Nate about this after he gets an ok from the customer to disclose
> his work.  It is not so simple as you claim.
> 

Nate, I would be very interested to hear about your work if
and when you are able to disclose it.

[snip devfs]

Yeah I was just trying to introduce some humour to the thread!
Or maybe deflate one flamewar by starting another :)

Nick

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
