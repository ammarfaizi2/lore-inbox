Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266981AbTAZUwA>; Sun, 26 Jan 2003 15:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbTAZUwA>; Sun, 26 Jan 2003 15:52:00 -0500
Received: from kunde0416.oslo-asen.alfanett.no ([62.249.189.163]:21772 "EHLO
	kunde0416.oslo-asen.alfanett.no") by vger.kernel.org with ESMTP
	id <S266981AbTAZUv6>; Sun, 26 Jan 2003 15:51:58 -0500
Date: Sun, 26 Jan 2003 22:01:05 +0100 (CET)
From: Peter Karlsson <peter@softwolves.pp.se>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 kernel crashes while scanning partition list
In-Reply-To: <3E33FC84.2080707@walrond.org>
Message-ID: <Pine.LNX.4.43.0301262158190.30005-100000@perkele>
Mail-Copies-To: Peter Karlsson <peter@softwolves.pp.se>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond:

> Sorry I don't have a copy of your first email, so apologies if you've
> already addressed these questions

My previous message is archived at
<URL:http://www.uwsg.indiana.edu/hypermail/linux/kernel/0301.2/0519.html>

> Is it just the 2.4.20 kernel? Have you tried others?

2.4.19 and 2.4.20 crashes, 2.4.18 as distributed with Debian 3.0's
installation system works fine, but it needs to be told where the IDE
channels are. It seems that the change in 2.4.18->2.4.19 that
introduces support for recognizing where the FastTrak card has its IDE
channels somehow causes the crash. However, manually specifying the IDE
channels on the command line as for 2.4.18 does not make 2.4.19/20 stop
crashing.

> Can we see some dmesg output?

Please see the previous post.

-- 
\\//
Peter - http://www.softwolves.pp.se/

  I do not read or respond to mail with HTML attachments.


