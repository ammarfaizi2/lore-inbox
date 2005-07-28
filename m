Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVG1XCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVG1XCp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 19:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVG1XCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 19:02:45 -0400
Received: from graphe.net ([209.204.138.32]:10142 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261875AbVG1XCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 19:02:43 -0400
Date: Thu, 28 Jul 2005 16:02:41 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@ucw.cz>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Task notifier: Implement todo list in task_struct
In-Reply-To: <20050728221228.GB1872@elf.ucw.cz>
Message-ID: <Pine.LNX.4.62.0507281559400.15569@graphe.net>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net>
 <Pine.LNX.4.62.0507272018060.11863@graphe.net> <20050728074116.GF6529@elf.ucw.cz>
 <Pine.LNX.4.62.0507280804310.23907@graphe.net> <20050728193433.GA1856@elf.ucw.cz>
 <Pine.LNX.4.62.0507281251040.12675@graphe.net> <Pine.LNX.4.62.0507281254380.12781@graphe.net>
 <20050728212715.GA2783@elf.ucw.cz> <20050728213254.GA1844@elf.ucw.cz>
 <Pine.LNX.4.62.0507281456240.14677@graphe.net> <20050728221228.GB1872@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005, Pavel Machek wrote:

> > Dont fix it up. Remove the ealier patch.
> 
> Oops. Do you happen to have patch relative to -mm or something? I'd
> prefer not to mess it up second time...

Ok. I will make a patch against mm tomorrow. Patches 
are typically against Linus latest and if you test against mm then you may 
see breakage from other patches. Plus there will be dependencies with 
other patches in mm.

