Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291717AbSBHSeE>; Fri, 8 Feb 2002 13:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291711AbSBHSdy>; Fri, 8 Feb 2002 13:33:54 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:16342 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S291707AbSBHSdn>;
	Fri, 8 Feb 2002 13:33:43 -0500
Date: Fri, 8 Feb 2002 13:33:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Martin Wirth <Martin.Wirth@dlr.de>
cc: Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
        linux-kernel@vger.kernel.org, akpm@zip.com.au, mingo@elte.hu,
        haveblue@us.ibm.com
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <3C641511.9555ED47@dlr.de>
Message-ID: <Pine.GSO.4.21.0202081322330.28514-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Feb 2002, Martin Wirth wrote:

> But this approach needs a lot a proper documentation and discipline.

... and this attitude is my main beef with B^WLSE crowd.

Folks, if you have nothing else to do - *don't* mess with locking just
for the heck of it.  And yes, you are supposed to understand WTF you
are doing.

