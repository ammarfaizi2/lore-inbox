Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135673AbRDSNzu>; Thu, 19 Apr 2001 09:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135676AbRDSNzq>; Thu, 19 Apr 2001 09:55:46 -0400
Received: from athena.intergrafix.net ([206.245.154.69]:37515 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S135673AbRDSNze>; Thu, 19 Apr 2001 09:55:34 -0400
Date: Thu, 19 Apr 2001 09:55:32 -0400 (EDT)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: linux-kernel@vger.kernel.org
Subject: quota problems 2.4.2->2.4.3
Message-ID: <Pine.LNX.4.10.10104190944001.5773-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

WHen i upgrade from 2.2 to 2.4, my first version was 2.4.1,
in which i upgraded my quota utils to 3.00 and then converted to the new
quota formats for 2.4.
my last 2.4 upgrade was 2.4.2ac23, quotas work fine on that.
but when i run 2.4.3 they dont. quota -v on a user shows just blank space
next to the user name, edquota shows the quota numbers, but that's it,
changing them and redoing quota -v is the same.
everything puts the users over quota. doing a quotacheck shows the quota
files corrupted..yet boot back to 2.4.2ac23 and they work fine again.
did something change in 2.4.3? or does quota utils need to be upgraded
again? if so, where can i can them (i forget where i got them last time)

Thanx,

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.


