Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266115AbTABRKr>; Thu, 2 Jan 2003 12:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266203AbTABRKr>; Thu, 2 Jan 2003 12:10:47 -0500
Received: from 12-224-209-133.client.attbi.com ([12.224.209.133]:4224 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266115AbTABRKl>; Thu, 2 Jan 2003 12:10:41 -0500
Subject: Re: Raw data from dedicated kernel bug database
From: "Timothy D. Witham" <wookie@osdl.org>
To: Larry McVoy <lm@bitmover.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
       Dave Jones <davej@codemonkey.org.uk>, Randy Dunlap <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030102025605.GE23419@work.bitmover.com>
References: <20030101194019.GZ5607@work.bitmover.com>
	 <12310000.1041456646@titus> <20030101221510.GG5607@work.bitmover.com>
	 <1041473017.22606.8.camel@irongate.swansea.linux.org.uk>
	 <45160000.1041475166@titus>  <20030102025605.GE23419@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Open Source Development Lab, Inc.
Message-Id: <1041524136.1491.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 02 Jan 2003 08:15:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Sorry for the slow response I'm on vacation and sharing
the computer with 4 teenagers who are all addicted
to IRC.  But I think that Martin can get this done.

  Martin if you need help from my folks please contact
them and get this done.

Tim

On Wed, 2003-01-01 at 18:56, Larry McVoy wrote:
> > Larry, can I presume that you'll reciprocate, and export whatever you
> > do to the data in BK in some argument-free format (probably the same
> > one we export to you)? 
> 
> Yup.  A BK database is actually a BK repostory with an SQL layer on 
> top of it.  So all of the stuff you can do with BK you can do with 
> BK/Database.  We can export changes as patches, as flat files, as
> associative arrays in perl, take your pick.
> 
> > I think the concerns I had about tools going wild are actually fairly
> > easy to resolve by making it a pull-pull interchange ... don't know
> > why I was thinking of push models.
> 
> Cool.  I've already tracked down an SQL hacker who is willing to contract
> with us to write the scripts to get the data out of your Bugzilla database.
> He said that I need to ask you to do this:
> 
> 	shut down the mysql database
> 	grab all the MySQL files and stuff them in a tarball
> 	turn on the mysql database again
> 
> Then he can set up a mysql instance here and start hacking on the scripts.
> How's that sound?
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

