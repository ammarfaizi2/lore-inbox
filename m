Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266016AbUGTQ7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266016AbUGTQ7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 12:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266021AbUGTQ7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 12:59:05 -0400
Received: from unicorn.sch.bme.hu ([152.66.208.4]:45037 "EHLO
	unicorn.sch.bme.hu") by vger.kernel.org with ESMTP id S266016AbUGTQ7D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 12:59:03 -0400
Date: Tue, 20 Jul 2004 18:58:55 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.8-rc2 - ACPI still broken
Message-ID: <20040720165855.GB19102@unicorn.sch.bme.hu>
References: <Pine.LNX.4.58.0407172237370.12598@ppc970.osdl.org> <1090333194.2368.6.camel@forum-beta.geizhals.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090333194.2368.6.camel@forum-beta.geizhals.at>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 04:19:54PM +0200, Thomas Zehetbauer wrote:
> ACPI support is still broken for the Intel D865PERL board. Booting hangs
> when compiled for SMP/HT and succeeds only with acpi=off or acpi=ht boot
> parameter.

It is still broken for Intel D865GRH too, as I reported first using 
2.6.7-rc3.


-- 
pozsy
