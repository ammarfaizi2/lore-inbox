Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263643AbTCUQJ2>; Fri, 21 Mar 2003 11:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263645AbTCUQJ2>; Fri, 21 Mar 2003 11:09:28 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:59657 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S263643AbTCUQJ1>; Fri, 21 Mar 2003 11:09:27 -0500
Date: Fri, 21 Mar 2003 11:20:24 -0500 (EST)
From: root <root@oddball.prodigy.com>
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.64] X unlock doesn't work
Message-ID: <Pine.LNX.4.44.0303211040490.5604-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now there's a new one... I just noticed that in my 2.5.64 kernel, when my 
screensaver comes up and asks for a password to unlock, no matter what 
password I give it is rejected. With 2.5.59 passwords work for the user 
logged in.

Redhat 7.3, GNOME.

I just noticed because this is the first time since 2.5.64 came out that I 
did anything from console, since it's a mail machine, stats collector, 
etc.

I'll try 2.5.65 next week when I have more time.
-- 
bill davidsen <davidsen@tmr.com>

