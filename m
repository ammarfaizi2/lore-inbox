Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291343AbSBGV4H>; Thu, 7 Feb 2002 16:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291347AbSBGVzs>; Thu, 7 Feb 2002 16:55:48 -0500
Received: from 1Cust15.tnt15.sfo3.da.uu.net ([67.218.75.15]:4365 "EHLO
	morrowfield.home") by vger.kernel.org with ESMTP id <S291346AbSBGVzb>;
	Thu, 7 Feb 2002 16:55:31 -0500
Date: Thu, 7 Feb 2002 17:02:46 -0800 (PST)
Message-Id: <200202080102.RAA09003@morrowfield.home>
From: Tom Lord <lord@regexps.com>
To: phillips@bonn-fries.net
CC: linux-kernel@vger.kernel.org
In-Reply-To: <E16Yw0S-000163-00@starship.berlin> (message from Daniel Phillips
	on Thu, 7 Feb 2002 22:23:00 +0100)
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207165035.GA28384@ravel.coda.cs.cmu.edu> <200202072306.PAA08272@morrowfield.home> <E16Yw0S-000163-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Noted.  Yours would seem to be the more popular opinion.  I don't feel
strongly against changing it.

-t



   On February 8, 2002 12:06 am, Tom Lord wrote:
   > The name has curly braces so that it sorts reasonably (i.e. away from
   > ordinary source files).  It is not a dot file so that you can
   > recognize at a glance when you are looking at the root of a project
   > tree.

   I'd pass on that to get rid of the extra 'noise'.  If for some reason I'm not 
   sure - and I consider that unlikely to ever occur - I can always ls .* or 
   find -name ".*arch*" if I'm really confused.

   I like my directories to look clean, *especially* the source root.

   -- 
   Daniel


