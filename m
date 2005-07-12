Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVGLC5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVGLC5K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 22:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVGLC5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 22:57:09 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:28376 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261906AbVGLC4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 22:56:03 -0400
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
From: Lee Revell <rlrevell@joe-job.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <200507111538.22551.s0348365@sms.ed.ac.uk>
References: <200507061257.36738.s0348365@sms.ed.ac.uk>
	 <20050711141232.GA16586@elte.hu> <20050711141622.GA17327@elte.hu>
	 <200507111538.22551.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 22:56:00 -0400
Message-Id: <1121136960.2632.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 15:38 +0100, Alistair John Strachan wrote:
> I realise 4KSTACKS is a considerable rework of the IRQ handler, etc. and 
> probably even more heavily modified by rt-preempt, but is there nothing else 
> that can be tested before a serial console run?
> 

Well, netconsole is a lot quicker to set up than serial, but AIUI can
fail in some cases where serial console succeeds.

Lee 

