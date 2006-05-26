Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbWEZVco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWEZVco (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbWEZVco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:32:44 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:7135 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S1751593AbWEZVcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:32:43 -0400
Message-ID: <4477737C.6020708@stanford.edu>
Date: Fri, 26 May 2006 14:30:36 -0700
From: Brannon Klopfer <bklopfer@stanford.edu>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: can't resume with recent kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have an IBM ThinkPad 600E. It runs perfectly with 2.6.15.1: namely, I 
can suspend (apm -s) and resume without trouble.

I just upgraded to 2.6.16.18. Suspending works fine, but resuming just 
locks it up completely: terminal cursor doesn't blink, caps lock won't 
respond, can't VT switch, etc. As far as I know, my .config was the same 
for each.

I can try to see exactly when this got broken, if that would help.

Thanks,
Brannon Klopfer


