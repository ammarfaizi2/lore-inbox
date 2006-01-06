Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752534AbWAFUSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbWAFUSr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbWAFUSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:18:47 -0500
Received: from xenotime.net ([66.160.160.81]:13755 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752534AbWAFUSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:18:46 -0500
Date: Fri, 6 Jan 2006 12:18:44 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Arjan van de Ven <arjan@infradead.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Matthew Wilcox <matthew@wil.cx>,
       "Luck, Tony" <tony.luck@intel.com>, hawkes@sgi.com,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       John Hesterberg <jh@sgi.com>, Greg Edwards <edwardsg@sgi.com>
Subject: Re: [PATCH] ia64: change defconfig to NR_CPUS==1024
In-Reply-To: <1136578666.2548.1.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0601061217500.1545@shark.he.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F055A7B6B@scsmsx401.amr.corp.intel.com>
  <20060106174957.GF19769@parisc-linux.org> 
 <Pine.LNX.4.62.0601060958110.17665@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0601061017510.11324@shark.he.net> 
 <Pine.LNX.4.62.0601061035510.17875@schroedinger.engr.sgi.com> 
 <1136573948.2940.65.camel@laptopd505.fenrus.org> <1136578666.2548.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Alan Cox wrote:

> On Gwe, 2006-01-06 at 19:59 +0100, Arjan van de Ven wrote:
> > things differently; when a config option needs deciding you look at the
> > description and pick a good value. That's it. Defconfig doesn't matter.
>
> defconfig is 'Linus config', and he's stated as much before along with
> polite hints that this wasn't going to change. The vendor default config
> s are actually far saner for most users.

Right (Linus's config) for i386 (& ppc64 ?).
Probably not his for ia64 or Arm...

> Do vendors look at defconfig - not really, much more interesting is
> every other vendors config choices 8)

-- 
~Randy
