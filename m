Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWGJO2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWGJO2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161165AbWGJO2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:28:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31180 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161024AbWGJO2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:28:36 -0400
Message-ID: <44B262DA.10403@redhat.com>
Date: Mon, 10 Jul 2006 07:23:22 -0700
From: Kristen Carlson Accardi <kaccardi@redhat.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: len.brown@intel.com, torvalds@osdl.org
Subject: Re: Revert "ACPI: dock driver"
References: <200607091559.k69Fx2h0029447@hera.kernel.org>
In-Reply-To: <200607091559.k69Fx2h0029447@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> commit 953969ddf5b049361ed1e8471cc43dc4134d2a6f
> tree e4b84effa78a7e34d516142ee8ad1441906e33de
> parent b862f3b099f3ea672c7438c0b282ce8201d39dfc
> author Linus Torvalds <torvalds@g5.osdl.org> Sun, 09 Jul 2006 22:47:46 -0700
> committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 09 Jul 2006 22:47:46 -0700
>
> Revert "ACPI: dock driver"
>
> This reverts commit a5e1b94008f2a96abf4a0c0371a55a56b320c13e.
>
> Adrian Bunk points out that it has build errors, and apparently no
> maintenance. Throw it out.
>
>   
For the record, this driver is most definitely maintained (in fact I 
sent a patch for
a different problem on Friday).  Thank you to Len for sorting this all 
out.  It's been
a busy 2 weeks.

Kristen

