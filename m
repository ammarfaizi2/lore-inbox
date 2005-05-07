Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbVEGF5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVEGF5o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 01:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbVEGF5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 01:57:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:47040 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262724AbVEGF5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 01:57:42 -0400
Date: Fri, 6 May 2005 22:59:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.12-rc4
Message-ID: <Pine.LNX.4.58.0505062245160.2233@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You know the drill.

git trees, patches, tar-balls, you name it. I've still not made a shortlog 
script, and right now I'm too tired to generate the shortlog from the full 
log, so you can either find it all in the git archives, or just parse down 
the full log in ChangeLog-2.6.12-rc4 to a more manageable format.

Both the full log and the diffstat are too big for the mailing list to 
accept, so I'll not spam your mailboxes.

But you could just use gitweb, in case you haven't noticed already. So
point your browsers at http://www.kernel.org/git and see what you find out
that way.

What's changed? ia64, arm, UML, ppc64, jfs, cifs updates. And drivers. And 
tons of small stuff all over.

Me, I'm off for a week of vacationing. Flee the country, like I usually do 
after releases. Leave you suckers^H^H^H^H^H^H^Hgentle people to test it 
all out.

			Linus
