Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132439AbRAPTV0>; Tue, 16 Jan 2001 14:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132357AbRAPTVR>; Tue, 16 Jan 2001 14:21:17 -0500
Received: from nic.lth.se ([130.235.20.3]:26816 "EHLO nic.lth.se")
	by vger.kernel.org with ESMTP id <S132439AbRAPTVA>;
	Tue, 16 Jan 2001 14:21:00 -0500
Date: Tue, 16 Jan 2001 20:20:41 +0100
From: Jakob Borg <jakob@borg.pp.se>
To: Chris Mason <mason@suse.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG with 2.4.1-pre7 reiserfs
Message-ID: <20010116202041.A1285@borg.pp.se>
In-Reply-To: <20010116195837.A707@borg.pp.se> <215700000.979672723@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <215700000.979672723@tiny>; from mason@suse.com on Tue, Jan 16, 2001 at 02:18:43PM -0500
X-Operating-System: Linux narayan 2.4.1-pre7 i686 SMP 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 02:18:43PM -0500, Chris Mason wrote:
> When you mount the FS it tells you which version it is, please include that
> info as well.

I am rebooting with the patch from you (Chris) in about 30 seconds. This is
the output from reiserfs when booting:

reiserfs: checking transaction log (device 16:41) ...
reiserfs: replayed 5 transactions in 4 seconds
Using tea hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25

-- 
Jakob Borg            mailto:jakob@borg.pp.se       (personal)
UNIX/network admin    mailto:jakob@debian.org    (development)
systems programmer    mailto:jakob@morotsmedia.se       (work)
                      http://jakob.borg.pp.se/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
