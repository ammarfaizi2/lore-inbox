Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264630AbVBDUun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264630AbVBDUun (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266247AbVBDUpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:45:13 -0500
Received: from mail.linicks.net ([217.204.244.146]:49290 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S265977AbVBDUks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:40:48 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Post install 2.4.29 causes many apps to seg fault.
Date: Fri, 4 Feb 2005 20:40:46 +0000
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502042040.46367.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is there something more that I need to compile besides the kernel for 
>> compatability or is this a sign of some type of bug.  I do realize that 
RHEL3 
>> itself has some proprietary items added to their kernel but replacing it 
>> shouldn't make other applications fails.
>> 
>> Any assistance would be greatly appreciated.
>> 
> If lots of things fail in strange places, I would wonder if your glibc
> is compatible with your kernel. I suggest you take it up on a redhat
> mailinglist.

Yes, I had a similar problems at work when I  up2date'd the latest GLIBC for 
RHEL 3 late last year.  A colleague in Montreal (I am in UK) sussed what was 
going on.  I will _presume_ you are seeing similar problems with a kernel 
build.

Here is the link that explains it... what to do with many processes 
segfaulting, I don't know.  RHEL support is _very_ good - give them a ring.

http://people.redhat.com/drepper/assumekernel.html

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
