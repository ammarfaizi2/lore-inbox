Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267947AbTBYO52>; Tue, 25 Feb 2003 09:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267907AbTBYO52>; Tue, 25 Feb 2003 09:57:28 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:29395 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S267947AbTBYO51>; Tue, 25 Feb 2003 09:57:27 -0500
Message-ID: <3E5B86BA.2080802@blue-labs.org>
Date: Tue, 25 Feb 2003 10:07:38 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030224
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jaroslav Kysela <perex@suse.cz>
Subject: ALSA update for 2.5.62 porks up cs46xx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horrible echo and drawn out sound play.  Reversing the patch for 
cx46xx_lib.c fixes it.

David

-- 
I may have the information you need and I may choose only HTML.  It's up to you. Disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.

When it absolutely, positively, has to be destroyed overnight.
                           AIR FORCE


