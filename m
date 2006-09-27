Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965484AbWI0Jvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965484AbWI0Jvi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965487AbWI0Jvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:51:38 -0400
Received: from mx1.suse.de ([195.135.220.2]:44432 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965484AbWI0Jvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:51:37 -0400
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] i386: replace intermediate array-size definitions with ARRAY_SIZE()
References: <200609261445.21537.bjorn.helgaas@hp.com>
From: Andi Kleen <ak@suse.de>
Date: 27 Sep 2006 11:51:36 +0200
In-Reply-To: <200609261445.21537.bjorn.helgaas@hp.com>
Message-ID: <p73odt1k57b.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <bjorn.helgaas@hp.com> writes:

> Code is easier to validate if array sizes aren't hidden behind extra
> #defines.

Added thanks

I did a similar change for x86-64.

-Andi
