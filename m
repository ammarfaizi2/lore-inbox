Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265434AbUAZCGO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 21:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265437AbUAZCGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 21:06:14 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:64167
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265434AbUAZCGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 21:06:12 -0500
Message-ID: <40147637.20806@tmr.com>
Date: Sun, 25 Jan 2004 21:06:47 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Pavel Machek <pavel@ucw.cz>, Valdis.Kletnieks@vt.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sched-idle and disk-priorities for 2.6.X
References: <20040117232926.GC9999@elf.ucw.cz> <Pine.LNX.4.44.0401181346480.28955-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0401181346480.28955-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Sun, 18 Jan 2004, Pavel Machek wrote:
> 
> 
>>Is there effective way to limit RSS?
> 
> 
> Want me to port the RSS stuff from 2.4-rmap to 2.6 ?

What's the effort? It's useful for programs which use a lot of memory, 
particularly for those which only do it on some data sets. It would 
certainly act as a safty net.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
