Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267446AbUJIVlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267446AbUJIVlT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 17:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267450AbUJIVj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 17:39:26 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:50849 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267446AbUJIViA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 17:38:00 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xis9ja82z.fsf@mru.ath.cx>
References: <41677E4D.1030403@mvista.com> <yw1xk6u0hw2m.fsf@mru.ath.cx>
	 <1097356829.1363.7.camel@krustophenia.net>  <yw1xis9ja82z.fsf@mru.ath.cx>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1097357878.1363.15.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 17:37:59 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 17:35, Måns Rullgård wrote:

> I did notice one improvement compared to vanilla 2.6.8.1.  The sound
> didn't skip when I switched from X to a text console.  However, my
> keyboard no longer worked in X, but that seems to be due to some
> recent changes to the input subsystem.
> 
> Did you build it with our without my patch, BTW?

With.  Most of the modules did not work without your patch.

Lee

