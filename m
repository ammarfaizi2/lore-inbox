Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbTGXP4q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 11:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271702AbTGXP4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 11:56:46 -0400
Received: from tmi.comex.ru ([217.10.33.92]:62356 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S266169AbTGXP4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 11:56:44 -0400
X-Comment-To: Felipe Alfaro Solana
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-mm2 ext3-related OOPS while running tar
From: Alex Tomas <bzzz@tmi.comex.ru>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Organization: HOME
References: <1059038117.577.23.camel@teapot.felipe-alfaro.com>
	<87adb4hwde.fsf@gw.home.net>
	<1059052151.577.7.camel@teapot.felipe-alfaro.com>
Date: Thu, 24 Jul 2003 20:11:19 +0000
Message-ID: <87fzkvfzx4.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Felipe Alfaro Solana (FAS) writes:

 FAS> Well, at least with your patch applied I can't reproduce the previous
 FAS> oops while untarring the kernel sources. I'm going to use
 FAS> 2.6.0-test1-mm2 with your patch as my main kernel and will see if the
 FAS> oops is gone forever.

this is Andrew's patch

