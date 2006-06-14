Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWFNFNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWFNFNI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWFNFNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:13:08 -0400
Received: from xenotime.net ([66.160.160.81]:23700 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964877AbWFNFNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:13:06 -0400
Date: Tue, 13 Jun 2006 22:15:52 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andi Kleen <ak@suse.de>
Cc: tadavis@lbl.gov, linux-kernel@vger.kernel.org
Subject: Re: Athlon CPU detection/fixup is broken in 2.6.2-rc2
Message-Id: <20060613221552.6ab46ac6.rdunlap@xenotime.net>
In-Reply-To: <p73odwwqq7c.fsf@verdi.suse.de>
References: <401ACA49.8070002@lbl.gov>
	<p73odwwqq7c.fsf@verdi.suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Jun 2006 07:08:39 +0200 Andi Kleen wrote:

> Thomas Davis <tadavis@lbl.gov> writes:
> 
> > I looked in the Changelog - who changed it?
> > 
> > It doesn't work on my dual athlon 2200 MP system - kills it dead.
> > 
> > I can get 2.6.2-rc1 to boot.
> 
> Very vague report. Modern kernel like 2.6.16 doesn't work? And where
> does it crash exactly and in what way?
> 
> If you got it down to that release with binary search can you identify the
> exact changeset that caused the problem? 

Uhm, I admit that I ignored it given the kernel version and
date:
Date:	Fri, 30 Jan 2004 13:19:05 -0800

---
~Randy
