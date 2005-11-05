Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbVKEHxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbVKEHxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 02:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbVKEHxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 02:53:09 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:40302 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751461AbVKEHxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 02:53:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:Content-Type:Content-Transfer-Encoding;
  b=eD0tz3DjU4HWDP4MqtzrMayIfKn5uzIaV84o2DJ8UxrtfzU1qvy+HzEyqDHT0TU5Lw7zYCidQdY/RL4wrz4lH41cm1rLAtVEW8pG2BofZ0RXxxHqHZQSggMLz44CNHkyds4R25oLEa36Je7IR2x1sKTwr3Vy09bIlych8opLww4=  ;
Message-ID: <436C655F.2080703@yahoo.com.au>
Date: Sat, 05 Nov 2005 18:55:11 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch 0/4] atomic primitives again
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be nice if these could get in week 2 of the window.
Though they'll need wide compile testing (which I haven't been
able to provide), actual new arch specific code is limited to
ARM.

Compiled and booted on i386 and i686 configs, ppc64.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
