Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313131AbSDERDq>; Fri, 5 Apr 2002 12:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313133AbSDERDg>; Fri, 5 Apr 2002 12:03:36 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:2315 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S313131AbSDERDV>; Fri, 5 Apr 2002 12:03:21 -0500
Date: Fri, 5 Apr 2002 18:02:54 +0100
To: linux-kernel@vger.kernel.org
Subject: Init data debugging
Message-ID: <20020405170254.GA2092@berserk.demon.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@berserk.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would it be feasible to add a kernel debugging option which rather than
discarding init data/code sections just marked the pages as not
accessible, so illegal accesses could be caught ?

P.
