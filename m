Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVCYM21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVCYM21 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 07:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVCYM21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 07:28:27 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:18385 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261317AbVCYM2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 07:28:24 -0500
Date: Fri, 25 Mar 2005 13:28:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V8
In-Reply-To: <20050325014411.GA7698@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0503251326590.20353@yvahk01.tjqt.qr>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
 <20050325014411.GA7698@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I don't think 1 guarantees no performance degradation. After all, it
>is average load and scrubd might run at just the wrong times. Perhaps
>it should default to 0?

My load never gets below 1.00, because I run BOINC. This is the only app, so 
scrubbing could be done nonetheless (around the memory area which boinc uses).



Jan Engelhardt
-- 
