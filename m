Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUFPWx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUFPWx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 18:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266339AbUFPWx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 18:53:57 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:47827 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S264297AbUFPWxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 18:53:52 -0400
Subject: Re: [PATCH] Stairacse scheduler v6.E for 2.6.7-rc3
From: Alastair Stevens <alastair@altruxsolutions.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Haverhill UK
Message-Id: <1087426430.13988.4.camel@dolphin.chalkstone.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Jun 2004 23:53:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hi, does this resolve the issue with ut2004? (Or is another setting
>> for it needed?) I haven't tried myself, but others reported that
>> setting interactive to 0 didn't help, nor giving ut2004 more priority
>> via (re)nice.
>
>Good question. I don't own UT2004 so I was hoping a tester might
>enlighten me.
>
>Con

Well, I can report that it looks just fine from here.  I'm running 2.6.7
with the staircase patch, and UT2004 - as well as everything else -
works great.  Machine is an Athlon XP 2600+ with nVidia FX 5600.  I
haven't tweaked any nice values or /proc settings.

FWIW, the whole 2.6.7 experience seems great.  All of the mysterious
troubles I had with 2.6.6 (eg failing to call init) seem to have
vanished, and everything is running beautifully again.  For me, at
least, 2.6.6 was a very ungreased turkey, but now I'm happy again!

Cheers
Alastair

-- 
                                        o
Alastair Stevens : child of 1976       /-'_              LPI (Level 1)
>> www.altruxsolutions.co.uk          |\/(*)   /\__     Linux Certified
_________________________________ . .(*) _____/    \___________________
Still browsing with IE?  GET WITH THE PROGRAM @ www.mozilla.org/firefox

