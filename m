Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311255AbSCQCmS>; Sat, 16 Mar 2002 21:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311262AbSCQCmH>; Sat, 16 Mar 2002 21:42:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36625 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311255AbSCQCl5>; Sat, 16 Mar 2002 21:41:57 -0500
Date: Sat, 16 Mar 2002 18:40:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 7.52 second kernel compile
In-Reply-To: <15507.63649.587641.538009@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0203161834250.1591-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Mar 2002, Paul Mackerras wrote:
> 
> But this is all a bit academic, the real question is how do we deal
> most efficiently with the real hardware that is out there.  And if you
> want a 7.5 second kernel compile the only option currently available
> is a machine whose MMU uses a hash table. :)

Yeah, at a cost of $2M+, if I'm not mistaken. I think I'll settle for my 2
minute time that is actually available to mere mortals at a small fraction
of one percent of that ;)

		Linus

