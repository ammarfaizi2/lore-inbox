Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbUFJTCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUFJTCK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 15:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUFJTAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 15:00:23 -0400
Received: from s-smtp-osl-02.bluecom.no ([62.101.193.41]:5851 "EHLO
	s-smtp-osl-02.bluecom.no") by vger.kernel.org with ESMTP
	id S262391AbUFJS7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 14:59:49 -0400
Message-ID: <40C8AFA4.3040705@globelan.net>
Date: Thu, 10 Jun 2004 20:59:48 +0200
From: Lars Age Kamfjord <lakmailing@globelan.net>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: stian@nixia.no
Subject: Re: timer + fpu stuff locks my console race
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACK on 2.6.5 (fedora core 2 vanilla)

Totally locked my X window system.

Lars Age Kamfjord

 > Please keep me in CC as I'm not on the mailinglist. I'm currently on a
 > vaccation, so I can't hook my linux-box to the Internet, but I came 
across
 > a race condition in the "old" 2.4.26-rc1 vanilla kernel.

 > I'm doing some code tests when I came across problems with my program
 > locking my console (even X if I'm using a xterm).

 > I think first of all gcc triggers the problem, so the full report is 
here:
 > http://gcc.gnu.org/bugzilla/show_bug.cgi?id=15905

 > Stian Skjelstad
