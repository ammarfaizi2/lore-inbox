Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbUAEKjm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 05:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUAEKjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 05:39:42 -0500
Received: from web13910.mail.yahoo.com ([216.136.172.95]:46988 "HELO
	web13910.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263953AbUAEKjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 05:39:41 -0500
Message-ID: <20040105103940.34389.qmail@web13910.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Mon, 5 Jan 2004 02:39:40 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Any changes in Multicast code between 2.4.20 and 2.4.22/23 ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 besides wishing everybody a Happy new Year 2004, I have one question.
Have there been any changes in the multicast handling between 2.4.20
and 2.4.22/23? Maybe specific to the "tg3" driver?

 Reason for my question is that the Ganglia monitoring toolkit stopped
working with 2.4.22/23 kernels. Apparently mulicatst get sent, but
nothing is received.

 Any ideas?

Thanks
Martin

=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
