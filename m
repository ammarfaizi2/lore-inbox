Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265089AbUFGVhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbUFGVhR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUFGVhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:37:15 -0400
Received: from hostmaster.org ([212.186.110.32]:52887 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S265088AbUFGVhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:37:05 -0400
Subject: Re: Linux 2.6.7-rc3 / ACPI broken
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406071227400.2550@ppc970.osdl.org>
References: <Pine.LNX.4.58.0406071227400.2550@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1086644221.2341.8.camel@forum-beta.geizhals.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 07 Jun 2004 23:37:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI seems to be broken on Intel D865PERL board, I can only boot with
acpi=off, otherwise the kernel either hangs after the "ACPI: Subsystem
revision 20040326" message or shows a seemingly random oops message.

Tom


