Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291317AbSBGVTQ>; Thu, 7 Feb 2002 16:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291318AbSBGVTG>; Thu, 7 Feb 2002 16:19:06 -0500
Received: from dsl-213-023-038-235.arcor-ip.net ([213.23.38.235]:3474 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291316AbSBGVSy>;
	Thu, 7 Feb 2002 16:18:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Tom Lord <lord@regexps.com>, jaharkes@cs.cmu.edu
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Date: Thu, 7 Feb 2002 22:23:00 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207165035.GA28384@ravel.coda.cs.cmu.edu> <200202072306.PAA08272@morrowfield.home>
In-Reply-To: <200202072306.PAA08272@morrowfield.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Yw0S-000163-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
