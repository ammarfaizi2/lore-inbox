Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267710AbSLTDcl>; Thu, 19 Dec 2002 22:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267711AbSLTDck>; Thu, 19 Dec 2002 22:32:40 -0500
Received: from franka.aracnet.com ([216.99.193.44]:6363 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267710AbSLTDck>; Thu, 19 Dec 2002 22:32:40 -0500
Date: Thu, 19 Dec 2002 19:40:22 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: John Bradford <john@grabjohn.com>, Dave Jones <davej@codemonkey.org.uk>
cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, lm@bitmover.com,
       lm@work.bitmover.com, torvalds@transmeta.com, vonbrand@inf.utfsm.cl,
       akpm@digeo.com
Subject: Re: Dedicated kernel bug database
Message-ID: <79780000.1040355621@titus>
In-Reply-To: <200212192042.gBJKgsTl002677@darkstar.example.net>
References: <200212192042.gBJKgsTl002677@darkstar.example.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've got loads of ideas about how we could build a better bug database

Go ahead, knock yourself out. Come back when you're done.

> - for example, we have categories at the moment in Bugzilla.  Why?  We
> already have a MAINTAINERS file, so say somebody looks up the relevant
> maintainer in that list, finds them, then goes to enter a bug in
> Bugzilla.  Now they have to assign it to a category, and different
> people may well assign the same bug to different categories -
> immediately making duplicate detection more difficult.

Have you actually looked at the maintainers file? It's a twisted mess
of outdated information, in no well formated order. The category list
in Bugzilla was an attempt to bring some sanity to the structure,
though I won't claim it's perfect. We really need a 3-level tree, but
that's a fair amount of work to code.

M.



