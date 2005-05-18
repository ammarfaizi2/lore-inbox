Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVERTEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVERTEG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 15:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVERTEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 15:04:05 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29587 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262279AbVERTD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 15:03:58 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       randy_dunlap <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org, ak@suse.de
In-Reply-To: <20050518185016.GD1952@elf.ucw.cz>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw>
	 <20050516150907.6fde04d3.akpm@osdl.org>
	 <Pine.LNX.4.62.0505161934220.25315@graphe.net>
	 <20050516194651.1debabfd.rdunlap@xenotime.net>
	 <Pine.LNX.4.62.0505161954470.25647@graphe.net>
	 <Pine.LNX.4.58.0505162029240.18337@ppc970.osdl.org>
	 <20050518185016.GD1952@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 18 May 2005 15:03:53 -0400
Message-Id: <1116443033.5419.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 20:50 +0200, Pavel Machek wrote:
> Please don't do this, CONFIG_NO_IDLE_HZ patches are better solution,
> and they worked okay last time I tried them.

Last time the dynamic tick patches were posted, you reported they worked
fine.  The next question is, when do they get merged?

Lee

