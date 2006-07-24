Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWGXSzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWGXSzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 14:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWGXSzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 14:55:39 -0400
Received: from ns1.suse.de ([195.135.220.2]:60603 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932292AbWGXSzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 14:55:38 -0400
From: Andreas Gruenbacher <a.gruenbacher@computer.org>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: include/linux/xattr.h: how much userpace visible?
Date: Mon, 24 Jul 2006 20:58:53 +0200
User-Agent: KMail/1.9.1
Cc: Nathan Scott <nathans@sgi.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, James Morris <jmorris@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>
References: <20060723184343.GA25367@stusta.de> <200607242031.11815.a.gruenbacher@computer.org> <20060724184534.GA26842@mars.ravnborg.org>
In-Reply-To: <20060724184534.GA26842@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607242058.54299.a.gruenbacher@computer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 24 July 2006 20:45, Sam Ravnborg wrote:
> The userspace headers are supposed to hold the part of the kernel
> definitions that glibc (and mayby the attr package) uses. If they happen
> to have their own copy now should not impct the decision what is part of
> the userspace interface for the kernel. So actual usage does not decide
> what is part of the userspace kernel headers but what definitionas are
> definitions the userspace <-> kernel interface.

Sure, fine by me.

Andreas
