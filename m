Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262733AbTC0BEv>; Wed, 26 Mar 2003 20:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262734AbTC0BEu>; Wed, 26 Mar 2003 20:04:50 -0500
Received: from mta9-0.mail.adelphia.net ([64.8.50.199]:56986 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP
	id <S262733AbTC0BEu>; Wed, 26 Mar 2003 20:04:50 -0500
Subject: Adaptect 2940u2 w/ 2.4.20 or 2.5.59
From: "Anthony R. Mattke" <tonhe@adelphia.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1048727751.1225.10.camel@hiku.iphere.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 26 Mar 2003 20:15:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a current linux desktop curring 2.4.19 that has been running fine
for ever. Altho, when I atempted to do an update to 2.4.20, I was rather
surprised to see that my machine kernel panics on boot, just as it would
normally init the scsi bus.

The machine in question is an x86 SMP system (p3) with an adaptect
2940u2 card.. it also has another scsi controller on the mobo that is
disabled in bios. it is a 2940uw.

Is there any reason why the newer kernel has a problem with this card ?
I have tried both adaptect drivers for this card.. the new one that
started shipping in .20 and the olderone.. 

Has anyone else seen this problem? Its a current show stopper, I need to
reinstall my desktop, but the newer version of slackware ships with
2.4.20.

Any help would be appreciated.. 

Thanks.. 

-- 
Anthony R. Mattke <tonhe@adelphia.net>

