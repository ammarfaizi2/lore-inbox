Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262291AbSJQWum>; Thu, 17 Oct 2002 18:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbSJQWum>; Thu, 17 Oct 2002 18:50:42 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:20370 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262291AbSJQWul>;
	Thu, 17 Oct 2002 18:50:41 -0400
Date: Thu, 17 Oct 2002 15:52:05 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Bug tracking in the run up from 2.5 to 2.6
Message-ID: <205680000.1034895125@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're proposing to create a bug tracking system to help keep track of
2.5 kernel bugs ... in an attempt to help get 2.5 stabilised as quickly as
possible. 

It would be based on Bugzilla, and open for anyone to log bugs against
2.5, though those would then be filtered by a set of "maintainers" to keep
the quality of the data up to snuff. Ideally those would be the subsystem
maintainers as we know them now, though in the event that certain people
weren't interested, we'd find a "bugzilla maintainer" for the subsystem to
fill that role.

IBM's Linux Technology Centre is willing to provide the machine, admin, 
and people to help maintain the data in the database. We have someone
who's kindly agreed in principle to host the machine for us (feel free to 
speak up if you like, otherwise I'll wait until the proposal is firmed up).

We'll also have a slew of engineers dedicated to stabilise 2.5 after the
freeze, but this is not intended to be solely an IBM thing by any means;
we're volunteering to host the tracking database on behalf of the community,
and do some of the dirty work of administration. The intent is to have this
up and running by Halloween, and for a signification cross-section of the 
community to use it.

So ... are the maintainers interested in working with this kind of system?
We really need to get some feedback before commiting resources to doing
this - if you'd be willing to close out bugs as you find / fix them, please let
me know. This is a web interface system, with handy email triggers, and is
very easy to use.

Feedback saying "well, it'll only be useful if you do XYZ" is welcome too.
We're very unlikely to change tools to use something other than Bugzilla
at this point, so that's not really open for debate.

Martin.

