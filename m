Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbUASH7y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 02:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbUASH7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 02:59:54 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:57527 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S264449AbUASH7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 02:59:53 -0500
To: "Yu, Luming" <luming.yu@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>,
       "Jesse Barnes" <jbarnes@sgi.com>
Subject: Re: [patch] 2.6.1-mm3 acpi frees free irq0
References: <3ACA40606221794F80A5670F0AF15F8401720CEE@PDSMSX403.ccr.corp.intel.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 19 Jan 2004 02:59:46 -0500
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CEE@PDSMSX403.ccr.corp.intel.com>
Message-ID: <yq0hdys8j2l.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> ">" == Yu, Luming <luming.yu@intel.com> writes:

>> In this specific case the prom doesn't have it in it's tables, so
>> not finding it is expected behavior.

>> What's your machine type, and BIOS version?  This specific box
>> seems to be short of fundamental ACPI power button support.

Oh it's very short of those features, it really only uses ACPI to
provide system setup information and thats about it. It's an Altix box
fwiw.

Cheers,
Jes
