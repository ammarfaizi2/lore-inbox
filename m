Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268217AbTCFRpE>; Thu, 6 Mar 2003 12:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268222AbTCFRpE>; Thu, 6 Mar 2003 12:45:04 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:8207 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S268217AbTCFRpC>; Thu, 6 Mar 2003 12:45:02 -0500
Date: Thu, 6 Mar 2003 17:55:33 +0000
From: John Levon <levon@movementarian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-ID: <20030306175533.GA29400@compsoc.man.ac.uk>
References: <Pine.LNX.4.44.0303061819160.14218-100000@localhost.localdomain> <Pine.LNX.4.44.0303060936301.7206-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303060936301.7206-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18qzah-0007WE-00*w0Fcma/MKw.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 09:42:03AM -0800, Linus Torvalds wrote:

> But it was definitely there. 3-5 second _pauses_. Not slowdowns.

It's still there. Red Hat 8.0, 2.5.63. The  thing can pause for 15+
seconds (and during this time madplay quite happily trundled on playing
an mp3). Workload was KDE, gcc, nothing exciting...

john
