Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSLTPBt>; Fri, 20 Dec 2002 10:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbSLTPBt>; Fri, 20 Dec 2002 10:01:49 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:27817 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262395AbSLTPBr>;
	Fri, 20 Dec 2002 10:01:47 -0500
Subject: Re: Dedicated kernel bug database
From: Jon Tollefson <kniht@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Hanna Linder <hannal@us.ibm.com>, Eli Carter <eli.carter@inet.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <56310000.1040350825@flay>
References: <200212192155.gBJLtV6k003254@darkstar.example.net>
	<3E0240CA.4000502@inet.com> <42790000.1040337942@w-hlinder>
	<50260000.1040348396@flay> <71820000.1040349694@w-hlinder> 
	<56310000.1040350825@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 20 Dec 2002 09:09:31 -0600
Message-Id: <1040396972.925.295.camel@skynet.rchland.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 20:20, Martin J. Bligh wrote:
> >> Anything in "OPEN" state isn't really assigned to anyone yet.
> >> (the state would really better be named "NEW", but it's not). 
> >> People should move it to "ASSIGNED" if they're working on it.
> > 
> > 	So the process is to query for all open bugs (but not 
> > assigned) then email each person to let them know you are 
> > working on it?
> 
> Sounds about right. If we had processes ;-)
> 
> >> Go to file a new bug, click on the link by the subcategories, and it'll
> >> tell you (you'll have to pick the main category first).
> > 
> > 	That is convoluted. You have to file a bug to find out who
> > the subsystem maintainers are? Can you put it somewhere more
> > obvious?
> 
> Well, you don't have to file one, you just pretend to. But it's
> not nice, I agree. Jon, is there an easier way to do this, and get
> all the information in one shot?
> 
> M.
> 
> 
> 

There is also a link to it on the query page - the Components label. 
Basically its a link to
http://bugzilla.kernel.org/describecomponents.cgi
We could put a link to it on the main page or elsewhere too if that
would be more convenient.  It would be easy enough to write a page to
show all the component owners in one shot too if desired. 

Jon


