Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUGTOUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUGTOUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 10:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUGTOUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 10:20:06 -0400
Received: from hostmaster.org ([212.186.110.32]:33971 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S265897AbUGTOTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 10:19:55 -0400
Subject: Re: Linux 2.6.8-rc2 - ACPI still broken
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0407172237370.12598@ppc970.osdl.org>
References: <Pine.LNX.4.58.0407172237370.12598@ppc970.osdl.org>
Content-Type: text/plain
Date: Tue, 20 Jul 2004 16:19:54 +0200
Message-Id: <1090333194.2368.6.camel@forum-beta.geizhals.at>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI support is still broken for the Intel D865PERL board. Booting hangs
when compiled for SMP/HT and succeeds only with acpi=off or acpi=ht boot
parameter.

Regards
Tom

