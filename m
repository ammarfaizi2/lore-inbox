Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263048AbTDVKFC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 06:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbTDVKFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 06:05:02 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:31688 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S263048AbTDVKFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 06:05:00 -0400
Date: Tue, 22 Apr 2003 06:12:57 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts
  files
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304220616_MC3-1-356C-831E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

.>> I have forced another rebuild, but the problem with disappearing /dev/pts
.>> persists.
.>
.> This one ontop should really fix it...
.>
.> (fingers crossed..)
.>

Is this problem in 2.5.68-vanilla?

If so, would somebody please post a complete patch?


------
 Chuck
