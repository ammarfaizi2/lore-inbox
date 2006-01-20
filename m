Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWATOP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWATOP3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 09:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWATOP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 09:15:29 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:39086 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751000AbWATOP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 09:15:28 -0500
Date: Fri, 20 Jan 2006 15:15:23 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nick Warne <nick@linicks.net>
cc: Willy Tarreau <willy@w.ods.org>, Rumi Szabolcs <rumi_ml@rtfm.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernel uptime counter problem
In-Reply-To: <200601192022.42087.nick@linicks.net>
Message-ID: <Pine.LNX.4.61.0601201513360.22940@yvahk01.tjqt.qr>
References: <20060119110834.bb048266.rumi_ml@rtfm.hu>
 <7c3341450601190129r64a97880q22d576734214b6ac@mail.gmail.com>
 <20060119201857.GQ7142@w.ods.org> <200601192022.42087.nick@linicks.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > You can use:
>> > last -xf /var/run/utmp runlevel
>> >
>> > to get true uptime in this instance.

Or use some dedicated programs, IIRC there is a "uprecords" program
(http://podgorny.cz/moin/Uptimed). Does require no reboot and should 
work right away.


Jan Engelhardt
-- 
