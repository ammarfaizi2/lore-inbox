Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270374AbRHMSiB>; Mon, 13 Aug 2001 14:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270384AbRHMShv>; Mon, 13 Aug 2001 14:37:51 -0400
Received: from mta3n.bluewin.ch ([195.186.1.212]:52514 "EHLO mta3n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S270374AbRHMShn>;
	Mon, 13 Aug 2001 14:37:43 -0400
Message-ID: <3B776EA5000338FD@mta3n.bluewin.ch> (added by postmaster@bluewin.ch)
From: "Per Jessen" <per@computer.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 13 Aug 2001 20:46:20 +0200
Reply-To: "Per Jessen" <per@computer.org>
X-Mailer: PMMail 98 Professional (2.01.1600) For Windows 95 (4.0.1212)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: Are we going too fast?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, 13 Aug 2001 14:11:32 +0100 (BST), Alan Cox wrote:
>
>If you want maximum stability you want to be running 2.2 or even 2.0. Newer
>less tested code is always less table. 2.4 wont be as stable as 2.2 for a
>year yet.

Couldn't have put that any better. On mission-critical systems, this is
exactly what people do. Personally, my experience is from the big-iron
world of S390 -  if you're a bleeding-edge organisation, you'll be out
there applying the latest PTFs, you'll be running the latest OS/390 etc. 
If you're conservative, you're at least 2, maybe 3 releases (in todays 
OS390 this means about 18-24 months) behind. If you're ultra-conservative,
you'll wait for the point where you can no longer avoid an upgrade.


regards,
Per Jessen


regards,
Per Jessen, Zurich
http://www.enidan.com - home of the J1 serial console.

Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."


