Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTJITkB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 15:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbTJITkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 15:40:01 -0400
Received: from topaz-57.mcs.anl.gov ([140.221.57.209]:39299 "EHLO topaz")
	by vger.kernel.org with ESMTP id S262425AbTJITj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 15:39:58 -0400
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pmdisk performance problem
References: <Pine.LNX.4.44.0310091218210.985-100000@localhost.localdomain>
From: Narayan Desai <desai@mcs.anl.gov>
Date: Thu, 09 Oct 2003 14:39:42 -0500
In-Reply-To: <Pine.LNX.4.44.0310091218210.985-100000@localhost.localdomain> (Patrick
 Mochel's message of "Thu, 9 Oct 2003 12:21:09 -0700 (PDT)")
Message-ID: <87fzi2jj41.fsf@mcs.anl.gov>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pat" == Patrick Mochel <mochel@osdl.org> writes:

  >> When using 2.6.0-test7 on an ibm thinkpad t21, pmdisk works
  >> properly, though it takes quite a while to write out pages to
  >> disk. On my last suspend to disk, it took on the order of 8-10
  >> minutes. After this completed, i was able to successfully resume,
  >> fairly speedily, however my hardware clock was 8-10 minutes
  >> behind. Does anyone have any ideas why this is happening?
  >> thanks...

  Pat> Do you know if this was just for the write operation, or also
  Pat> included stopping all processes?

This was during the write of ~4600 pages to disk. 

  Pat> Could you increase the log-level before you suspend and let me
  Pat> know -- by looking at the debug messages -- what seems to take
  Pat> the most time?

sorry, but how do i do this?
thanks..
 -nld



