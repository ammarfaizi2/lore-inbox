Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWFPJuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWFPJuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 05:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWFPJuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 05:50:04 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:50421 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751161AbWFPJuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 05:50:02 -0400
Message-ID: <44927F91.6050506@manoweb.com>
Date: Fri, 16 Jun 2006 11:53:21 +0200
From: Alessio Sangalli <alesan@manoweb.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: APM problem after 2.6.13.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:98b9443de46bd48dbf34b16449aa5d76
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I've found a problem with kernels after 2.6.13.5.

I have an old (2001) laptop. Any kernel I tried:

2.6.14
2.6.14.7
2.6.15.7
2.6.16.2
2.6.16.9
2.6.16.16
2.6.16.20
2.6.17-rc6

if I enable "APM support" I get a freeze at the very beginning of the
boot, without any explicit erro message, just after the PCI stuff. If
you need a transcript of the messages at boot, let me know, I will have
to write them by hand).
2.6.13.5 is ok. I need APM support to let the "Fn" key and the battery
meter work!

I'm not subscribed to the lkml so please, CC me.

Thank you
Alessio Sangalli


