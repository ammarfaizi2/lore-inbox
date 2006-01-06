Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752535AbWAFUQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbWAFUQX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbWAFUQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:16:23 -0500
Received: from [81.2.110.250] ([81.2.110.250]:55505 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1752530AbWAFUQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:16:22 -0500
Subject: Re: [PATCH] ia64: change defconfig to NR_CPUS==1024
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Matthew Wilcox <matthew@wil.cx>,
       "Luck, Tony" <tony.luck@intel.com>, hawkes@sgi.com,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       John Hesterberg <jh@sgi.com>, Greg Edwards <edwardsg@sgi.com>
In-Reply-To: <1136573948.2940.65.camel@laptopd505.fenrus.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F055A7B6B@scsmsx401.amr.corp.intel.com>
	 <20060106174957.GF19769@parisc-linux.org>
	 <Pine.LNX.4.62.0601060958110.17665@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0601061017510.11324@shark.he.net>
	 <Pine.LNX.4.62.0601061035510.17875@schroedinger.engr.sgi.com>
	 <1136573948.2940.65.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Jan 2006 20:17:46 +0000
Message-Id: <1136578666.2548.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-01-06 at 19:59 +0100, Arjan van de Ven wrote:
> things differently; when a config option needs deciding you look at the
> description and pick a good value. That's it. Defconfig doesn't matter.

defconfig is 'Linus config', and he's stated as much before along with
polite hints that this wasn't going to change. The vendor default config
s are actually far saner for most users.

Do vendors look at defconfig - not really, much more interesting is
every other vendors config choices 8)

Alan

