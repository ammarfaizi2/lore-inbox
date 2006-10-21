Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1766636AbWJUSPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766636AbWJUSPJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766622AbWJUSPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:15:09 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:49809 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S637744AbWJUSPB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:15:01 -0400
Message-ID: <453A63A4.4070506@drzeus.cx>
Date: Sat, 21 Oct 2006 20:15:00 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
References: <4537EB67.8030208@drzeus.cx>	<Pine.LNX.4.64.0610191629250.3962@g5.osdl.org> <adabqo5lip8.fsf@cisco.com>
In-Reply-To: <adabqo5lip8.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>  > Other git maintainers may have other hints about how they work. Anybody?
>
> I use StGIT (http://www.procode.org/stgit/) to have sort of a hybrid
> git/quilt workflow.  My infiniband.git tree has the following main
> branches (I also keep other topic branches around):
>   

I've actually been using StGIT up until now. But I've started to feel a
need for sharing my tree, and StGIT isn't really suited for that.

How have you handled collaborative development on stuff that isn't ready
for Linus yet? Simply sending patches back and forth?

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

