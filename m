Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbULYNBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbULYNBd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 08:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbULYNBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 08:01:33 -0500
Received: from siaag1ag.compuserve.com ([149.174.40.13]:4050 "EHLO
	siaag1ag.compuserve.com") by vger.kernel.org with ESMTP
	id S261397AbULYNAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 08:00:35 -0500
Date: Sat, 25 Dec 2004 07:57:49 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.10-ck1
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200412250800_MC3-1-91AD-1E8B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> .fix_noswap.diff
> Build fix for config without swap

  So 2.6.10 won't build without swap enabled?

  This was a known problem; how did it get out the door without that fix?

--
Please take it as a sign of my infinite respect for you,
that I insist on you doing all the work.
                                        -- Rusty Russell
