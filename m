Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269098AbUHaWYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269098AbUHaWYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269128AbUHaWYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:24:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:1206 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269098AbUHaWRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:17:10 -0400
Date: Tue, 31 Aug 2004 15:20:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, perex@suse.de
Subject: Re: ALSA update broke Sparc
Message-Id: <20040831152049.1d7d4b48.akpm@osdl.org>
In-Reply-To: <s5heklnyvmg.wl@alsa2.suse.de>
References: <20040827183646.1da2befc.davem@davemloft.net>
	<s5h4qmkkjl5.wl@alsa2.suse.de>
	<s5heklnyvmg.wl@alsa2.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> Although I still couldn't set up the sparc cross-compile environment,

The tarballs at http://developer.osdl.org/dev/plm/cross_compile/ work nicely.
