Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279866AbRJ3FOx>; Tue, 30 Oct 2001 00:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279872AbRJ3FOn>; Tue, 30 Oct 2001 00:14:43 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:34696 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S279866AbRJ3FOZ>;
	Tue, 30 Oct 2001 00:14:25 -0500
Message-ID: <3BDE3756.2D004085@candelatech.com>
Date: Mon, 29 Oct 2001 22:15:02 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Realtek (VAIO laptop NIC) issue.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I do a warm reboot of my VAIO laptop, my realtek builtin NIC will not
function (it sees received pkts, but can't seem to send anything).

A cold boot fixes it.  An rmmod/insmod does not.  Not a horribly
big deal, but I thought I'd let you all know!  I was using 2.4.12-pre5
I believe...

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
