Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264432AbTCXV2z>; Mon, 24 Mar 2003 16:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264433AbTCXV2z>; Mon, 24 Mar 2003 16:28:55 -0500
Received: from mail148.mail.bellsouth.net ([205.152.58.108]:47444 "EHLO
	imf62bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S264432AbTCXV2x>; Mon, 24 Mar 2003 16:28:53 -0500
Date: Mon, 24 Mar 2003 15:39:53 -0600
To: linux-kernel@vger.kernel.org
Subject: Via8233 Onboard Sound Card (RE: [PATCH 2.4.20] Via 8233 Sound Support)
Message-ID: <20030324213953.GC508@smeagol.midgard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Adam Luter <luterac@bellsouth.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This in regards to a message back in December.

I thought I'd add that the patch (which adds the via 8233 chipset to
the list of valid chipsets for the via82cxxx audio module) does not
work on my system.

Not that important for me, since I have a spare "SB Live!" hanging
around.  But I thought maybe it would be helpful to report.
Unfortunately I don't know what details to report!  Just that it
didn't work and I get this error message (which, looking at the source
means some sort of write error to the card, er, chip):

via_audio: ignoring drain playback error -512

I'm using a cheap ECS board (though I'd have to look harder to know
the model) if that helps.  Let me know! :)

-Adam Luter

p.s. please CC, I'm not crazy enough to subscribe to this list (again!).
