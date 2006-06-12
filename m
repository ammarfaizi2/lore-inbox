Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751869AbWFLLIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbWFLLIG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 07:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbWFLLIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 07:08:05 -0400
Received: from ns2.suse.de ([195.135.220.15]:28047 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751865AbWFLLIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 07:08:00 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: x86_64: x86-64 mailing lists / posting patchkits / x86-64 releases
Date: Mon, 12 Jun 2006 13:07:54 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606121307.54556.ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo,

Some administrativa.

In the last time I've posted all patches I sent to Linus
at discuss@x86-64.org at least once. I did this because this list is relatively 
low volume and I tended to get some useful feedback from the people
subscribed here.

However I heard some rumours that I scared people away 
from the list with the many patches.  

I also planned to post patches more often to get better
turnaround for reviews on changed patches.

We still have a patches@x86-64 mailing list on x86-64.org which
is mostly unused. If I moved the big patch floods over there,
would the people who do reviews subscribe there? Please comment.

Also I'll probably start x86_64-* patchkit releases again. Currently
my working dir on ftp.firstfloor.org is directly going into -mm* and 
that sometimes causes problems because it is not as well tested as it would
be if a larger audience has run it. Also there are often non trivial
interactions with the many patches in -mm* and it's hard to figure
out where a problem comes from. So it looks like some separate 
testing would be better.

I hope people would be still interested in running x86_64-* patchkits.

Also my feeling is that I need to involve linux-kernel more. It seems
the majority of x86-64 users don't even know now this mailing list
exists, so they don't review or test the latest releases. Also
the traffic here seems to be less and less now except for me
(or do I just imagine that?) 

I suppose posting all patches there would be too much though, but
at least the announcements should be going there. I still think
it's valuable to have some kind of separate x86-64 list because
linux-kernel is just too much to keep up with and it would
drown valuable bug reports etc. in the general noise.

Any feedback from x86-64 contributors on how to organize this better welcome.

-Andi
 
