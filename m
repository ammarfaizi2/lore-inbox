Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130869AbRCFCfL>; Mon, 5 Mar 2001 21:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130873AbRCFCfF>; Mon, 5 Mar 2001 21:35:05 -0500
Received: from groveland.analogic.com ([204.178.47.17]:260 "EHLO
	groveland.analogic.com") by vger.kernel.org with ESMTP
	id <S130869AbRCFCep>; Mon, 5 Mar 2001 21:34:45 -0500
Date: Mon, 5 Mar 2001 21:35:30 -0500 (EST)
From: "Richard B. Johnson" <johnson@groveland.analogic.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.3
Message-ID: <Pine.LNX.4.21.0103052124250.1132-100000@groveland.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Attempts to run linux-2.4.3-pre2 on chaos.analogic.com results
in **MASSIVE** file-system destruction. I have (had) all SCSI
disks, using the BusLogic controller.

There is something **MAJOR** going on BAD, BAD, BAD, even disks
that were not mounted got trashed.

This is (was) a 400MHz SMP machine with 256 Mb of RAM. I don't
know what else to say, since I have nothing to mount. I can
"get back" but it will take several days. I have to install a
minimum system then restore everything from tapes.

I   -- S T R O N G L Y -- suggest that nobody use this kernel with
a BusLogic SCSI controller until this problem is fixed.

This is being sent from another machine, not on the list (actually
from home where I am trying to see what happened -- I brought all
4 of my disks home). It looks like some kind of a loop. I have
a pattern written throughout one of the disks.

Cheers,

Dick Johnson



