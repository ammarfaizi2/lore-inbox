Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbTIMJbW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 05:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbTIMJbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 05:31:22 -0400
Received: from streefland.xs4all.nl ([213.84.249.15]:3456 "EHLO zaphod.de.bilt")
	by vger.kernel.org with ESMTP id S262103AbTIMJbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 05:31:21 -0400
Date: Sat, 13 Sep 2003 11:31:19 +0200
From: Dick Streefland <Dick.Streefland@xs4all.nl>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5: Oops on mount /dev/md0
Message-ID: <20030913093119.GA2534@streefland.xs4all.nl>
References: <2ba3.3f5f8da3.bf8df@altium.nl> <16225.21682.619106.670945@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16225.21682.619106.670945@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 2003-09-12 15:08, Neil Brown wrote:
| Yeh... thanks for the report.
| This patch should fix it, and another case where an array that is
| really stopped accepts io requests and crashes.

Yes, the patch works. Thanks.

-- 
Dick Streefland                    ////               De Bilt
dick.streefland@xs4all.nl         (@ @)       The Netherlands
------------------------------oOO--(_)--OOo------------------
