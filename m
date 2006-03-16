Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932696AbWCPSKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbWCPSKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWCPSKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:10:22 -0500
Received: from xenotime.net ([66.160.160.81]:46998 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932696AbWCPSKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:10:21 -0500
Date: Thu, 16 Mar 2006 10:12:20 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: sam@ravnborg.org, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Message-Id: <20060316101220.67f4f33c.rdunlap@xenotime.net>
In-Reply-To: <20060316180047.GW27946@ftp.linux.org.uk>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
	<20060316160129.GB6407@infradead.org>
	<20060316082951.58592fdc.rdunlap@xenotime.net>
	<20060316163001.GA7222@infradead.org>
	<20060316174112.GA21003@mars.ravnborg.org>
	<20060316180047.GW27946@ftp.linux.org.uk>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006 18:00:47 +0000 Al Viro wrote:

> On Thu, Mar 16, 2006 at 06:41:12PM +0100, Sam Ravnborg wrote:
> > I assume that when you are not used to see 'bool', 'true' and 'false'
> > then they hurt the eye, but when used to it it looks natural.
> 
> Five words: kernel is written in C.
> 
> Not in Pascal.  Not in C++.  Not in Algol.  "When used to (something
> non-idiomatic in C) it becomes natural" is not a valid argument.

C (C99) now includes booleans.  Are we stuck pre-C99?

---
~Randy
