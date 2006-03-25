Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWCYSgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWCYSgh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWCYSgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:36:37 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:17295 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750750AbWCYSgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:36:36 -0500
Date: Sat, 25 Mar 2006 19:36:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Eric Sesterhenn <snakebyte@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Fix compilation for sound/oss/vwsnd.c
In-Reply-To: <1143151741.14516.1.camel@alice>
Message-ID: <Pine.LNX.4.61.0603251936080.29793@yvahk01.tjqt.qr>
References: <1143151469.13816.1.camel@alice> <1143151741.14516.1.camel@alice>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>sorry,
>
>fixed patch below between all the switching i forgot to remove
>the declaration in li_create()
>

It would have been a lot simpler to add a (proper) prototype.


Jan Engelhardt
-- 
