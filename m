Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265541AbTABFES>; Thu, 2 Jan 2003 00:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265564AbTABFES>; Thu, 2 Jan 2003 00:04:18 -0500
Received: from franka.aracnet.com ([216.99.193.44]:44013 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265541AbTABFER>; Thu, 2 Jan 2003 00:04:17 -0500
Date: Wed, 01 Jan 2003 21:12:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
       Dave Jones <davej@codemonkey.org.uk>,
       "Timothy D. Witham" <wookie@osdl.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Raw data from dedicated kernel bug database
Message-ID: <47690000.1041484350@titus>
In-Reply-To: <20030102025605.GE23419@work.bitmover.com>
References: <20030101194019.GZ5607@work.bitmover.com>
 <12310000.1041456646@titus> <20030101221510.GG5607@work.bitmover.com>
 <1041473017.22606.8.camel@irongate.swansea.linux.org.uk>
 <45160000.1041475166@titus> <20030102025605.GE23419@work.bitmover.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yup.  A BK database is actually a BK repostory with an SQL layer on
> top of it.  So all of the stuff you can do with BK you can do with
> BK/Database.  We can export changes as patches, as flat files, as
> associative arrays in perl, take your pick.

OK, something like that sounds good to me.

> Cool.  I've already tracked down an SQL hacker who is willing to contract
> with us to write the scripts to get the data out of your Bugzilla
> database. He said that I need to ask you to do this:
>
> 	shut down the mysql database
> 	grab all the MySQL files and stuff them in a tarball
> 	turn on the mysql database again
>
> Then he can set up a mysql instance here and start hacking on the scripts.
> How's that sound?

I'll leave the details to the database guys at OSDL, but I presume they
do backups in a similar fashion already, so ...

M.

