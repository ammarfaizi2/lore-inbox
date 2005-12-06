Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbVLFUgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbVLFUgq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbVLFUgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:36:46 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:29915 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030226AbVLFUgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:36:45 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <87mzjf2gxs.fsf@mid.deneb.enyo.de>
References: <20051203135608.GJ31395@stusta.de>
	 <1133620264.2171.14.camel@localhost.localdomain>
	 <20051203193538.GM31395@stusta.de> <1133639835.16836.24.camel@mindpipe>
	 <20051203225815.GH25722@merlin.emma.line.org>
	 <87y82z5kep.fsf@mid.deneb.enyo.de>
	 <1133816764.9356.72.camel@laptopd505.fenrus.org>
	 <87mzjf2gxs.fsf@mid.deneb.enyo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Dec 2005 20:35:53 +0000
Message-Id: <1133901354.23610.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-06 at 01:43 +0100, Florian Weimer wrote:
> As far as I know, many of the recent CVE assignments for kernel
> vulnerabilities have been done by MITRE, requested by individuals
> which are neither known as kernel developers, nor vendor security
> folks (for "vendor" as in "we have our own legal department with real
> lawyers").

Most of them will be because vendors employ security professionals to
handle security CVE work and do all the tedious and terribly important
tracking of bugs v releases and what needs to be fixed by whom and when
- and developers to write code.

> Maybe the source of CVE assignments paints a wrong picture.  But if
> the CVE picture is correct, vendor-paid kernel developers help behind
> the scenes, but there is little interest in openly documenting
> security issues, so that users (and what kernel.org considers fringe
> distros) can apply the relevant patches if they use kernel.org
> kernels.

The 2.6.x.y maintainers are directly involved in security@kernel.org
last time I checked.

> database.  But the only answers we get is that everything is fine,
> vendors handle the situation, security@kernel.org actually does this
> already, etc.

Having someone doing that on kernel.org sounds a good plan

