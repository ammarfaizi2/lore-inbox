Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbSLTRY4>; Fri, 20 Dec 2002 12:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSLTRY4>; Fri, 20 Dec 2002 12:24:56 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:62083 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262924AbSLTRYz>;
	Fri, 20 Dec 2002 12:24:55 -0500
Subject: Re: Dedicated kernel bug database
From: Jon Tollefson <kniht@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <76460000.1040355330@titus>
References: <200212191335.gBJDZRDL000704@darkstar.example.net>
	<3E020660.9020507@inet.com> <20021219184958.GA6837@suse.de> 
	<76460000.1040355330@titus>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 20 Dec 2002 11:32:45 -0600
Message-Id: <1040405565.989.416.camel@skynet.rchland.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 21:35, Martin J. Bligh wrote:
> > It's an annoyance to me that the current bugzilla we use can only
> > do 1 way email. Ie, I receive email when things change, but I can't
> > reply to that mail and have my comments auto-added.
> > Other bugzillas can do this, so I think either some switch needs
> > to be enabled, or theres some extension not present.
> > (I'm a complete bugzilla weenie, and no nothing about how its set up).
> 
> I think it's some extensions that can be used. Jon is the person
> who knows the Bugzilla tool itself ... Jon, any comments on this?
> 
> M.
> 
> 

There is a script in bugzilla that can be set up with procmail to accept
messages for appending comments.  Though there are some issues with it
that prevent even the mozilla site from enabling it in their own
bugzilla.  These are noted in
http://bugzilla.mozilla.org/show_bug.cgi?id=44393 as relating to
authentication and dealing with vacation/auto-responders. 

Perhaps this is an opportunity for someone that wants to work on a bug
tracker to enhance this script and contribute it to bugzilla.

Jon 


