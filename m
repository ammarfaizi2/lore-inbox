Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271737AbRIGLio>; Fri, 7 Sep 2001 07:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271738AbRIGLie>; Fri, 7 Sep 2001 07:38:34 -0400
Received: from f129.law10.hotmail.com ([64.4.15.129]:13325 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S271737AbRIGLiT>;
	Fri, 7 Sep 2001 07:38:19 -0400
X-Originating-IP: [194.65.14.70]
From: "Mack Stevenson" <mackstevenson@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: reiser@namesys.com, nerijus@users.sourceforge.net
Subject: Re: Basic reiserfs question
Date: Fri, 07 Sep 2001 13:38:34 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F1296yL2m9lHiu3fQtY00009c2d@hotmail.com>
X-OriginalArrivalTime: 07 Sep 2001 11:38:34.0750 (UTC) FILETIME=[A09CC9E0:01C13791]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, but there's something still troubling me: is getting the following 
lines written to syslog normal upon booting after a "clean" shutdown or an 
indicator of a "dirty" shutdown?

>From syslog, referring to the last time I booted my machine:

reiserfs: checking transaction log (device 03:02) ...
Warning, log replay starting on readonly filesystem
reiserfs: replayed 16 transactions in 4 seconds
using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.

Some times the second and third lines are present, some times they aren't...

Should I worry if I don't get such messages whenever I boot? Or should I 
worry if I get those messages after (apparently) clean shutdown procedures?

Or shouldn't I worry at all? ;-)

- Mack


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

