Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbTJ1RCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 12:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbTJ1RCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 12:02:53 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:2823 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264045AbTJ1RCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 12:02:52 -0500
Subject: re: [PATCH] PS/2 mouse rate setting
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20031028162520.1040.qmail@web14910.mail.yahoo.com>
References: <20031028162520.1040.qmail@web14910.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1067360565.1904.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Tue, 28 Oct 2003 18:02:46 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-28 at 17:25, Jon Smirl wrote:
> This patch has made my Microsoft PS/2 wheel mouse almost unusable. Setting
> acceleration to the max in Gnome is not enough to compensate for the change. I
> am not using a KVM.

I'm suffering the same pain as you... 2.6.0-test9-bk2 makes my PS/2
mouse almost unusable. 2.6.0-test9-bk1 worked fine.

