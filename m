Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265963AbUFIVNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265963AbUFIVNw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 17:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUFIVNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 17:13:51 -0400
Received: from gprs214-136.eurotel.cz ([160.218.214.136]:36482 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265963AbUFIVNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 17:13:48 -0400
Date: Wed, 9 Jun 2004 23:13:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mark Gross <mgross@linux.jf.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp "not enough swap space" 2.6.5-mm6.
Message-ID: <20040609211335.GA25031@elf.ucw.cz>
References: <200406080829.35120.mgross@linux.intel.com> <20040608230450.GA13916@elf.ucw.cz> <200406090832.04064.mgross@linux.intel.com> <200406090927.51206.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406090927.51206.mgross@linux.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have to get to my day job now, but whats up with the flakieness of the 
> swsusp?  Shouldn't it be mostly working by now?

As you noticed, it *is* mostly working. However there are about 1000
drivers, and about 3 people working on swsusp.

There's ACPI team at Intel, perhaps they are willing to help? ;-)
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
