Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757050AbWK0Fwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757050AbWK0Fwn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 00:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757052AbWK0Fwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 00:52:42 -0500
Received: from shells.gnugeneration.com ([207.44.156.13]:9683 "HELO
	shells.gnugeneration.com") by vger.kernel.org with SMTP
	id S1757053AbWK0Fwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 00:52:42 -0500
Date: Sun, 26 Nov 2006 23:52:39 -0600
From: lkml@pengaru.com
To: linux-kernel@vger.kernel.org
Subject: Forgotten patch to fs/locks.c
Message-ID: <20061127055239.GC9100@shells.gnugeneration.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am I mistaken or did this patch never make it into the kernel?

http://www.ussg.iu.edu/hypermail/linux/kernel/0409.2/0902.html

I had to apply that patch a short while ago to 2.6.12.4 to fix kernel
crashes with some web servers at my previous place of employment.

Just now getting around to following up on why it seemed to be left
behind.

Regards,
Vito Caputo
