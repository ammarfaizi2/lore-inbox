Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbTJ1RNc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 12:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264046AbTJ1RNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 12:13:31 -0500
Received: from web14909.mail.yahoo.com ([216.136.225.61]:16766 "HELO
	web14909.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264043AbTJ1RNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 12:13:31 -0500
Message-ID: <20031028171325.83155.qmail@web14909.mail.yahoo.com>
Date: Tue, 28 Oct 2003 09:13:25 -0800 (PST)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: re: [PATCH] PS/2 mouse rate setting
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1067360565.1904.2.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would it be better to do this with an IOCTL instead of a boot default? With an
IOCTL we could put things back like they were and then KVM switch users could
run an app to change the speed.

I'm reverting the code back on my system so that I can use my mouse again.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
