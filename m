Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbTGAGEz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 02:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbTGAGEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 02:04:55 -0400
Received: from u156n67.hfx.eastlink.ca ([24.222.156.67]:53132 "EHLO
	llama.nslug.ns.ca") by vger.kernel.org with ESMTP id S266001AbTGAGEy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 02:04:54 -0400
Date: Tue, 1 Jul 2003 03:19:15 -0300
To: linux-kernel@vger.kernel.org
Subject: some edits to the Kconfig online help (2.5.73)
Message-ID: <20030701061915.GA26385@llama.nslug.ns.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Cordes <peter@llama.nslug.ns.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Attached is a patch to arch/i386/Kconfig for Linux 2.5.73.  I didn't change
any logic, only the help messages.  I've fixed typos, made some messages
more clear and concise, and used my experience as a native English speaker
to make some corrections.  Besides purely editorial changes, I've added some
details here and there, and updated things that sound as if they were
written when PCI was brand new, or computers without 387 FPUs were common :)
I left in some old-sounding stuff that adds character; It's fun to know
Linux isn't written by robots.  (yet :)

 Please CC: me on any replies, as I'm not subscribed to the lkml.  Let me
know if the kind of straight-to-the-point help message I've made is good, or
if more "this option is used for ..." would be better, in case I feel like
tackling another one of these files.

 Happy hacking,

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@llama.nslug.n , s.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
