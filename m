Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263055AbUKTQSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbUKTQSX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 11:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUKTQRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 11:17:37 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:11023 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S263027AbUKTQRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 11:17:10 -0500
Date: Sat, 20 Nov 2004 17:17:07 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: Is controlling DVD speeds via SET_STREAMING supported?
Message-ID: <20041120161704.GA14743@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

currently my DVD player sounds like a jet plane when playing ordinary 
audio CD's. I tried the different approaches to lowering playback speed 
that are commonly used (hdparm, setspeed, etc) but none of them worked.

Then I found this thread:
http://marc.theaimsgroup.com/?t=99366299900003&r=1&w=2

Which seems to indicate that DVD players need a different command 
(SET_STREAMING), the thread is from 2001, and I've not been able to find 
any more recent information.

So, my question is, is this implemented in the kernel and are there any 
userspace tools to set the playback speed?

Regards,
David

PS
Please CC replies to my email address...
