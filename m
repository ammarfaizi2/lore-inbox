Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262688AbVCDB4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbVCDB4C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVCDBzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 20:55:54 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:61582 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262688AbVCDBwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 20:52:33 -0500
Subject: Re: RFD: Kernel release numbering
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, vonbrand@inf.utfsm.cl,
       jgarzik@pobox.com, davem@davemloft.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050303152825.08e7e4c6.akpm@osdl.org>
References: <200503031644.j23Gi0Eh011165@laptop11.inf.utfsm.cl>
	 <Pine.LNX.4.58.0503030855460.25732@ppc970.osdl.org>
	 <20050303152825.08e7e4c6.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 20:52:28 -0500
Message-Id: <1109901148.4224.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 15:28 -0800, Andrew Morton wrote:
> Subject: [Bugme-new] [Bug 4282] New: ALSA driver in Linux 2.6.11 causes a kernel panic when loading the EMU10K1 driver

Um... this one is highly suspect.  Myself and others have been doing a
lot of work on this driver lately, and have unloaded and reloaded it
hundreds and hundreds of times, and no one on the ALSA lists ever
reported this problem.  If this was real I really think we would have
heard of it a month ago.  The bug reporter did not even provide a
backtrace.

Lee 

