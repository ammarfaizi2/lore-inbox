Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVIOJnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVIOJnX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 05:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVIOJnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 05:43:22 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:48364 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932396AbVIOJnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 05:43:22 -0400
Date: Thu, 15 Sep 2005 11:43:05 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       George Anzinger <george@mvista.com>
Subject: Re: 2.6.13-rt6, ktimer subsystem
In-Reply-To: <20050913100040.GA13103@elte.hu>
Message-ID: <Pine.LNX.4.61.0509151142051.3743@scrub.home>
References: <20050913100040.GA13103@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 13 Sep 2005, Ingo Molnar wrote:

> there are lots of small updates all across and there's a big feature as 
> well in this release: a complete rework of the high-resolution timers 
> framework, from Thomas Gleixner, called 'ktimers'.

Is that somewhere available as separate patch?

bye, Roman
