Return-Path: <linux-kernel-owner+w=401wt.eu-S1754649AbWLRVuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649AbWLRVuG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 16:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754647AbWLRVuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 16:50:06 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:44067 "HELO abra2.bitwizard.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754649AbWLRVuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 16:50:05 -0500
Date: Mon, 18 Dec 2006 22:50:02 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Add a new section to CodingStyle, promoting include/linux/kernel.h.
Message-ID: <20061218215002.GL7280@harddisk-recovery.com>
References: <Pine.LNX.4.64.0612181238210.27907@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612181238210.27907@localhost.localdomain>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 12:43:35PM -0500, Robert P. J. Day wrote:
>   Add a new section to the CodingStyle file, encouraging people not to
> re-invent available kernel macros such as ARRAY_SIZE(),
> FIELD_SIZEOF(), min() and max(), among others.

Good stuff. Could you also mention the printk() KERN_ALERT etc. levels?
I've seen quite some people using "<1>" on the kernelnewbies list.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
