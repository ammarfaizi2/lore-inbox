Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131609AbRCXIqG>; Sat, 24 Mar 2001 03:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131610AbRCXIp4>; Sat, 24 Mar 2001 03:45:56 -0500
Received: from relay03.cablecom.net ([62.2.33.103]:10765 "EHLO
	relay03.cablecom.net") by vger.kernel.org with ESMTP
	id <S131609AbRCXIps>; Sat, 24 Mar 2001 03:45:48 -0500
Message-ID: <3ABC5E89.FB6A2C89@bluewin.ch>
Date: Sat, 24 Mar 2001 09:44:58 +0100
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.76 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: David Ford <david@blue-labs.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux should better cope with power failure
In-Reply-To: <3ABB6B82.62293CAD@uni-mb.si> <3ABBA400.2AEC97E8@bluewin.ch> <3ABBD11D.FE20FB69@blue-labs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, the correct answer is if you want a reliable recovery then run your disks
> in non write buffered mode.  I.e. turn on sync in fstab.
> 
You probably haven't tried to use sync or you would have noticed the
performace penalty. I think nobody really considers sync an alternative.

O. Wyss
