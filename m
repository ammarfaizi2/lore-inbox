Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271006AbTHFTmZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272071AbTHFTmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:42:25 -0400
Received: from smtp.terra.es ([213.4.129.129]:8069 "EHLO tsmtp7.mail.isp")
	by vger.kernel.org with ESMTP id S271006AbTHFTkd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:40:33 -0400
Date: Wed, 6 Aug 2003 21:40:23 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: Filesystem Tests
Message-Id: <20030806214023.74546b84.diegocg@teleline.es>
In-Reply-To: <20030806190850.GF21290@matchmail.com>
References: <3F306858.1040202@mrs.umn.edu>
	<20030805224152.528f2244.akpm@osdl.org>
	<3F310B6D.6010608@namesys.com>
	<20030806183410.49edfa89.diegocg@teleline.es>
	<20030806180427.GC21290@matchmail.com>
	<20030806204514.00c783d8.diegocg@teleline.es>
	<20030806190850.GF21290@matchmail.com>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 6 Aug 2003 12:08:50 -0700 Mike Fedyk <mfedyk@matchmail.com> escribió:

> But with servers, the larger your filesystem, the longer it will take to
> fsck.  And that is bad for uptime.  Period.

Sure. But Han's "don't benchmark ext2 because it's not an option" isn't
a valid stament, at least to me.

I'm not saying ext2 is the best fs on earth, but i *really* think
it's a real option, and as such, it must be benchmarked.
