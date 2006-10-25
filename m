Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422907AbWJYDve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422907AbWJYDve (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 23:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161337AbWJYDve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 23:51:34 -0400
Received: from pop-sarus.atl.sa.earthlink.net ([207.69.195.72]:47534 "EHLO
	pop-sarus.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1161335AbWJYDvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 23:51:33 -0400
Message-ID: <453EDF44.3090308@cfl.rr.com>
Date: Tue, 24 Oct 2006 23:51:32 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Background scan of sata drives
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to recall seeing mention flow by on the lkml at some point that 
sata disks are now scanned in the background rather than blocking in the 
modprobe, but that there is a new dummy module you can load that just 
blocks until all drives have been scanned.  I tried but was unable to 
find the thread that mentioned this, so does anyone know what that 
module was?

