Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272446AbTHIR3i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 13:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272454AbTHIR3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 13:29:38 -0400
Received: from tandu.perlsupport.com ([66.220.6.226]:65000 "EHLO
	tandu.perlsupport.com") by vger.kernel.org with ESMTP
	id S272446AbTHIR3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 13:29:37 -0400
Date: Sat, 9 Aug 2003 13:30:01 -0400
From: Chip Salzenberg <chip@pobox.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: NULL.  Again.  (was Re: [PATCH] 2.4.22pre10: {,un}likely_p())
Message-ID: <20030809173001.GG24349@perlsupport.com>
References: <1060087479.796.50.camel@cube> <20030809002117.GB26375@mail.jlokier.co.uk> <20030809081346.GC29616@alpha.home.local> <20030809015142.56190015.davem@redhat.com> <1060425774.4933.73.camel@dhcp22.swansea.linux.org.uk> <20030809162332.GB29647@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809162332.GB29647@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Jamie Lokier:
> Not just K&R.  These are different because of varargs:
> 	printf ("%p", NULL);
> 	printf ("%p", 0);

*SIGH*  I thought incorrect folk wisdom about NULL and zero and pointer
conversions had long since died out.  More fool I.  Please, *please*,
_no_one_else_ argue about NULL/zero/false etc. until after reading this:

  ===[[  http://www.eskimo.com/~scs/C-faq/s5.html  ]]===

I thank you, and linux users everywhere thank you.
-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
