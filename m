Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262581AbTCMWyY>; Thu, 13 Mar 2003 17:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262583AbTCMWyX>; Thu, 13 Mar 2003 17:54:23 -0500
Received: from pointblue.com.pl ([62.89.73.6]:16397 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id <S262581AbTCMWyW>;
	Thu, 13 Mar 2003 17:54:22 -0500
Subject: Re: mb800 watchdog driver
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: K4 Labs
Message-Id: <1047595955.21844.30.camel@gregs>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 22:52:35 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 16:10, Dave Jones wrote:

> devfs only drivers == EVIL. Pure EVIL.
well, since i am using only devfs and i don't see (personaly) any reason
to continue standard /dev directory structure i didn't wrote that part,
but if somebody really want it - patches are welcomed.

I've tried to remove all unneded parts, make it more kernel style of
programming compatible.

new version is on the same place where older one was, as i assume it
does not make sense to keep old one.

http://hit-six.co.uk/~gj/mb800_watchdog.tar.bz2

Cheers.

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 Labs

