Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264949AbUFDACa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUFDACa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 20:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbUFDAC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 20:02:29 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:64914 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264949AbUFDAB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 20:01:57 -0400
Message-ID: <40BFBBEE.5090003@yahoo.com.au>
Date: Fri, 04 Jun 2004 10:01:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <200406012022.i51KMFEB002660@turing-police.cc.vt.edu> <1086124536.2278.52.camel@localhost.localdomain> <c9naac$ps4$1@gatekeeper.tmr.com>
In-Reply-To: <c9naac$ps4$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> Just a thought, I'm pretty well convinced that Nick's latest patches 
> have reduced the problem, at least for me. I'll try to get some metrics 
> on the measured effect, but the "feel" is better by far.
> 

Well thanks for testing them. I have another version with
minor bug fixes and a sync up to recent -mm changes.

http://www.kerneltrap.org/~npiggin/nickvm-267r2m2.gz
