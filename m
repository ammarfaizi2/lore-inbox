Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266139AbUHWQYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUHWQYB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 12:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUHWQXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 12:23:25 -0400
Received: from topaz-57.mcs.anl.gov ([140.221.57.209]:3200 "EHLO topaz")
	by vger.kernel.org with ESMTP id S266139AbUHWQJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 12:09:12 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: apm problem with mm series
References: <87fz6dyj4q.fsf@topaz.mcs.anl.gov>
From: Narayan Desai <desai@mcs.anl.gov>
Date: Mon, 23 Aug 2004 11:07:08 -0500
In-Reply-To: <87fz6dyj4q.fsf@topaz.mcs.anl.gov> (Narayan Desai's message of
 "Mon, 23 Aug 2004 10:22:13 -0500")
Message-ID: <87smadvnwz.fsf@topaz.mcs.anl.gov>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Narayan" == Narayan Desai <desai@mcs.anl.gov> writes:

  Narayan> I have started having problems resuming my laptop (a
  Narayan> thinkpad t41p)f rom apm-induced sleep. Suspension occurs
  Narayan> after a longer period of time than with working kernels,
  Narayan> and resume never completes. the fans come back on and the
  Narayan> backlight turns on, but the system never returns. It is
  Narayan> unresponsive to sysrq keys, and eventually requires a power
  Narayan> cycle.  This problem started happening between
  Narayan> 2.6.8-rc3-mm2 and 2.6.8.1-mm1. 2.6.8.1-mm4 still exhibits
  Narayan> this problem. I am building a vanilla 2.6.8.1 kernel now to
  Narayan> try out now. I saw the issue with yenta socket problems, so
  Narayan> i disabled that support in the mm4 kernel, to no avail. I
  Narayan> realize that this isn't too much data to go on, but would
  Narayan> appreciate any suggestions.

This problem doesn't occur with vanilla 2.6.8.1.
 -nld



