Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264559AbTDYW4W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 18:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbTDYW4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 18:56:22 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:56293 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S264559AbTDYW4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 18:56:21 -0400
Date: Fri, 25 Apr 2003 19:02:27 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: TASK_UNMAPPED_BASE & stack location
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304251905_MC3-1-3615-631C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:


> (e.g. just moving __PAGE_OFFSET on amd64 to 4GB for 32bit broke some things)


  Wow.  The whole kernel is 'not there' as far as 32bit usermode
on x86-^h^h^h^hAMD64 is concerned then, right?

  Do you also get 'unlimited' space to run multiple 32-bit apps?


-------
 Chuck
