Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129271AbRBXME4>; Sat, 24 Feb 2001 07:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129273AbRBXMEp>; Sat, 24 Feb 2001 07:04:45 -0500
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:24194 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S129271AbRBXMEd>; Sat, 24 Feb 2001 07:04:33 -0500
Posted-Date: Sat, 24 Feb 2001 13:04:32 +0100 (MET)
Date: Sat, 24 Feb 2001 13:04:04 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200102241204.NAA24233@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2-ax2 / ac3 die silently
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've experienced Oops with 2.4.x and all the 2.4.1-ac versions of the kernel.
I've the same Oops with 2.4.2.

With 2.4.2-ac2 and ac3 (I've not not tested ac1). I've no OOps but, in the same
conditions, the system die silently ; without any message, nothing in the log
and the magic keys not working.

last time, this appended just after the message :
ax25_sendmsh(): ulistd uses obsolete socket structure

There is no problem at all with the 2.2 serie.

----------
Regards
		Jean-Luc
