Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271318AbTHCV7V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271331AbTHCV7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:59:21 -0400
Received: from gandalph.mad.hu ([193.225.158.7]:16397 "EHLO gandalph.mad.hu")
	by vger.kernel.org with ESMTP id S271318AbTHCV7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:59:18 -0400
Date: Mon, 4 Aug 2003 00:00:28 +0200
From: Gergely Nagy <algernon@bonehunter.rulez.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] compile fix for arch/ppc/kernel/setup.c
Message-ID: <20030803220027.GC18494@gandalph.mad.hu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030803204138.GB18494@gandalph.mad.hu> <200308031447.55659.miles.lane@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200308031447.55659.miles.lane@comcast.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm.  This doesn't look like the correct patch.  This one shows linux/config.h 
> being added, not linux/cpu.h.  How about this one, instead?

Bah! You're right. Sorry about the foobared patch.
