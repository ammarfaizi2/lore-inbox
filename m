Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUDLP5d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 11:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbUDLP5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 11:57:33 -0400
Received: from bay2-f96.bay2.hotmail.com ([65.54.247.96]:15883 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262438AbUDLP5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 11:57:32 -0400
X-Originating-IP: [209.172.74.2]
X-Originating-Email: [idht4n@hotmail.com]
From: "David L" <idht4n@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: digi_acceleport bug?
Date: Mon, 12 Apr 2004 08:57:29 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F96keTxtfkdpcz0004c7b2@hotmail.com>
X-OriginalArrivalTime: 12 Apr 2004 15:57:29.0472 (UTC) FILETIME=[DBA24000:01C420A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I submitted a bug report to bugzilla (bug #2459), but the problem couldn't 
be reproduced without the digi acceleport hardware.  Does anybody out there 
use a 4 port digi acceleport USB serial device?  If so, could you try to 
reproduce this bug?  It's pretty easy to try.  Plug in your acceleport, 
type:

cat /dev/ttyUSB0
unplug your acceleport.
Press control-c to stop the cat process.
See if your system hangs completely.

Thanks:

                  David

PS - I've seen the problem with a redhat 2.6.3-xxx and kernel.org 2.6.5.

_________________________________________________________________
MSN Toolbar provides one-click access to Hotmail from any Web page – FREE 
download! http://toolbar.msn.com/go/onm00200413ave/direct/01/

