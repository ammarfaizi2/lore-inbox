Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVCVVjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVCVVjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVCVVjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:39:10 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:48109 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262038AbVCVVi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:38:29 -0500
Date: Tue, 22 Mar 2005 22:38:27 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Distinguish real vs. virtual CPUs?
In-Reply-To: <42408D97.7000806@tmr.com>
Message-ID: <Pine.LNX.4.61.0503222236030.19826@yvahk01.tjqt.qr>
References: <88056F38E9E48644A0F562A38C64FB600448EE27@scsmsx403.amr.corp.intel.com>
 <42408D97.7000806@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For some Intel processors... Tom Vier just posted his cpuinfo which shows all
> of his processors, which he notes are in separate sockets, are identified as
> physical zero. I didn't find any Intel systems which lacked unique physical ID,
> but clearly that's not true everywhere.

Hmmh what will we do once there will be a dual-PS3 (*) chip?

(*) Currently pure imagination, but what I mean is a two-or-more-CPU machine
with each CPU having 8 CPUs, basically. The latter fact (8 CPUs on one cpu 
chip) is reality as far as my eye was sidetracked on a Playstation3 article
about their new CPU.



Jan Engelhardt
-- 
