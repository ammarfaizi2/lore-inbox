Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbTGENQD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 09:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266342AbTGENQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 09:16:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1721 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266341AbTGENQC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 09:16:02 -0400
Message-ID: <3F06D2ED.8080904@pobox.com>
Date: Sat, 05 Jul 2003 09:30:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [ANN] 2.4.x snapshots started
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just like 2.5.x, nightly snapshots of Marcelo's latest 2.4.x BK 
repository are being posted on kernel.org:

ftp://ftp.??.kernel.org/pub/linux/kernel/v2.4/snapshots/

I created the first snapshot midday as a test, and the standard cron job 
created a second one, so the current release is 2.4.21-bk2.

Note that snapshots are NOT based off -pre and -rc releases.  2.4.21-bkN 
will continue, for ascending values of N, until 2.4.22 is released.

Just like 2.5.x, when a new version is released, the old snapshots are 
moved into
ftp://ftp.??.kernel.org/pub/linux/kernel/v2.4/snapshots/old/

Just like 2.5.x, when a new snapshot appears, another automated job 
generates the incremental diff between this and the last snapshot:
ftp://ftp.??.kernel.org/pub/linux/kernel/v2.4/snapshots/incr/

	Jeff



