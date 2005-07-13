Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbVGMUTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVGMUTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVGMURu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:17:50 -0400
Received: from ns1.heckrath.net ([213.239.205.18]:44524 "EHLO
	mail.heckrath.net") by vger.kernel.org with ESMTP id S262738AbVGMURm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:17:42 -0400
Date: Thu, 14 Jul 2005 00:18:43 +0200
From: Sebastian Kaergel <mailing@wodkahexe.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: Linux v2.6.13-rc3
Message-Id: <20050714001843.3c14d071.mailing@wodkahexe.de>
In-Reply-To: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
References: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005 22:05:00 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> Dmitry Torokhov:
>   [ACPI] Enable EC Burst Mode

After booting 2.6.13-rc3 on my acer travlemate 291LCI it starts
complaining:

 acpi_ec-0217 [30] acpi_ec_leave_burst_mo: ------->status fail
 acpi_ec-0217 [30] acpi_ec_leave_burst_mo: ------->status fail

2.6.13-rc{1,2} did not have this problem.
