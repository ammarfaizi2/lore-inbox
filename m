Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264269AbUFNUnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbUFNUnM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 16:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUFNUlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 16:41:35 -0400
Received: from unicorn.sch.bme.hu ([152.66.208.4]:37275 "EHLO
	unicorn.sch.bme.hu") by vger.kernel.org with ESMTP id S264226AbUFNUj4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 16:39:56 -0400
Date: Mon, 14 Jun 2004 22:39:50 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc3 / ACPI broken
Message-ID: <20040614203950.GN6341@unicorn.sch.bme.hu>
References: <Pine.LNX.4.58.0406071227400.2550@ppc970.osdl.org> <1086644221.2341.8.camel@forum-beta.geizhals.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086644221.2341.8.camel@forum-beta.geizhals.at>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jun 07, 2004 at 11:37:01PM +0200, Thomas Zehetbauer wrote:
> ACPI seems to be broken on Intel D865PERL board, I can only boot with
> acpi=off, otherwise the kernel either hangs after the "ACPI: Subsystem
> revision 20040326" message or shows a seemingly random oops message.

Is there any progress about this bug?
I hit it too, even sent a few mails about it, but no real fix yet :(


-- 
Balazs Pozsar

