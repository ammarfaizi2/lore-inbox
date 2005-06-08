Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVFHMQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVFHMQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 08:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVFHMQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 08:16:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43242 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262188AbVFHMQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 08:16:22 -0400
Date: Wed, 8 Jun 2005 14:16:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: christoph <christoph@scalex86.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move some more structures into "mostly_readonly"
Message-ID: <20050608121607.GA1898@elf.ucw.cz>
References: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Move syscall table, timer_hpet and the boot_cpu_data into the
> "mostly_readonly" section.

What is "mostly readonly" section usefull for? It looks ugly to my
eyes. Does it help performance or what?
								Pavel
