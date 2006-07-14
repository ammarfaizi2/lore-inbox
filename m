Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422667AbWGNTHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422667AbWGNTHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422679AbWGNTHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:07:25 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.4.201]:17965 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1422667AbWGNTHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:07:24 -0400
Date: Fri, 14 Jul 2006 15:07:23 -0400
From: Michael Lindner <mikell@optonline.net>
Subject: Re: PROBLEM: close(fd) doesn't wake up read(fd) or select() in another
 thread
In-reply-to: <200607141146.52908.mikell@optonline.net>
To: linux-kernel@vger.kernel.org
Message-id: <200607141507.23501.mikell@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <200607141146.52908.mikell@optonline.net>
User-Agent: KMail/1.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update: On advice from Nish Aravamudan I upgraded my kernel to 2.6.17.4 and 
verified that the problem still exists in that version.

Thanks,
-- 
Michael Lindner
