Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267697AbSLTBjd>; Thu, 19 Dec 2002 20:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267700AbSLTBjd>; Thu, 19 Dec 2002 20:39:33 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:64966 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267697AbSLTBja>; Thu, 19 Dec 2002 20:39:30 -0500
Date: Thu, 19 Dec 2002 17:39:56 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hanna Linder <hannal@us.ibm.com>
cc: Eli Carter <eli.carter@inet.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Dedicated kernel bug database
Message-ID: <50260000.1040348396@flay>
In-Reply-To: <42790000.1040337942@w-hlinder>
References: <200212192155.gBJLtV6k003254@darkstar.example.net> <3E0240CA.4000502@inet.com> <42790000.1040337942@w-hlinder>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Bug tracking can get much better (I _hope_!), but I expect it to take some beating on the problem.  Keep beating on it.
> 
> OK. Since we are on the topic. I have some (intending to be) constructive
> criticisms for the owners of the 2.5 kernel tracker site (not sure exactly 
> who they are but I know mbligh is part of it).
> 
> Why are bugs automatically assigned to owners? 
> 	If there was an unassigned category that would make it 
> 	easy to query.

The "default owner" is someone to dispostion the bug ... not necessarily
to fix it.
 	
> How else are those of us who want to help stabilize the 2.5 kernel supposed 
> 	to know which bugs are being worked on and which are not? 
> 	(Please dont tell me "email". Am I really supposed to email every 
> 	person who has a bug asking if they are really working on it or not?)

Anything in "OPEN" state isn't really assigned to anyone yet.
(the state would really better be named "NEW", but it's not). 
People should move it to "ASSIGNED" if they're working on it.
 
> Could you make a list of all the people who have volunteered to be
> 	bugtracker maintainers and their respective kernel pieces. 

Go to file a new bug, click on the link by the subcategories, and it'll
tell you (you'll have to pick the main category first).
 
> Also a list of people who arent maintainers but are available to help 
> 	could be useful for the owners to assign bugs to.

Not sure the best way to work this to be honest ... it may work better
as a pull system ... pick something that looks interesting and grab it.
You won't have permission to just change the owner field, but you can
add comments to bugs, and / or email the owner in question.

There are a bunch of categories that aren't really "owned" as such,
and default to khoa or myself. Those are really good candidates to
steal ... they'll be owned by bugme-janitors soon to make this more
obvious ...

M.

