Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbTCDX03>; Tue, 4 Mar 2003 18:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbTCDX03>; Tue, 4 Mar 2003 18:26:29 -0500
Received: from shfd-3e353944.pool.mediaWays.net ([62.53.57.68]:19843 "EHLO
	unicorn.encapsulated.net") by vger.kernel.org with ESMTP
	id <S265863AbTCDX01>; Tue, 4 Mar 2003 18:26:27 -0500
Date: Tue, 4 Mar 2003 23:32:38 +0000
From: Beneath <ishikodzume@beneath.plus.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: EXT3: linux-2.4.21-pre5
Message-Id: <20030304233238.0014a165.ishikodzume@beneath.plus.com>
In-Reply-To: <20030303210956.M1373@schatzie.adilger.int>
References: <20030304024714.647cc75d.ishikodzume@beneath.plus.com>
	<20030303210956.M1373@schatzie.adilger.int>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So, could you check in /var/log/messages (or whatever) to see if you
> have the original error?  It might not have been written to disk if
> the error is on the /var filesystem.  If that is the case, is it
> possible for you to set up a serial console or network syslog to
> capture the full errors?

I looked in messages before i posted to the ML - no errors.
And... because of the very rare occurance of this so far... i don't
think i'm likely to get anything soon with the network syslog, but i'll
set it up anyway just incase.

No one else reported anything like this, then?

Thanks,
 - Daniel

