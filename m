Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277316AbRKHSJz>; Thu, 8 Nov 2001 13:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277435AbRKHSJq>; Thu, 8 Nov 2001 13:09:46 -0500
Received: from sushi.toad.net ([162.33.130.105]:13018 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S277294AbRKHSJj>;
	Thu, 8 Nov 2001 13:09:39 -0500
Subject: Re: Laptop harddisk spindown?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 08 Nov 2001 13:08:59 -0500
Message-Id: <1005242943.20873.928.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i have a disk access _every_ 5 sec, unregarding the system load,

I used to have this problem sometimes when my CD-ROM drive
had no disk in it.  I would get an infinite series of
"disk change detected" messages in the syslog.  The writes
to the syslog kept the disk from spinning down.

Thomas

