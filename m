Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263741AbUEGUMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUEGUMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUEGULn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:11:43 -0400
Received: from web90006.mail.scd.yahoo.com ([66.218.94.64]:18269 "HELO
	web90006.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S263776AbUEGULb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:11:31 -0400
Message-ID: <20040507194448.24330.qmail@web90006.mail.scd.yahoo.com>
Date: Fri, 7 May 2004 12:44:48 -0700 (PDT)
From: read lkml <read_lkml@yahoo.com>
Subject: Question regarding switch_to on x86
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could anyone please explain to me (or point me to some
documentation) the need for the 3rd argument in the
switch_to macro on x86? Why is it 
switch_to(prev, next, last)? how are prev and last
different? 

Thanks


	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
