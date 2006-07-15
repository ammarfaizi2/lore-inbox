Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945994AbWGOEah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945994AbWGOEah (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 00:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945996AbWGOEah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 00:30:37 -0400
Received: from xenotime.net ([66.160.160.81]:62647 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1945994AbWGOEag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 00:30:36 -0400
Date: Fri, 14 Jul 2006 21:33:23 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jim Gifford <maillist@jg555.com>, bunk@stusta.de
Cc: davem@davemloft.net, dwmw2@infradead.org, arjan@infradead.org,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: 2.6.18 Headers - Long
Message-Id: <20060714213323.e610b348.rdunlap@xenotime.net>
In-Reply-To: <44B80543.4050608@jg555.com>
References: <44B7F062.8040102@jg555.com>
	<1152905987.3159.46.camel@laptopd505.fenrus.org>
	<1152908202.3191.98.camel@pmac.infradead.org>
	<20060714.131957.57444250.davem@davemloft.net>
	<44B80543.4050608@jg555.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006 13:57:39 -0700 Jim Gifford wrote:

>  When I wrote my script to sanitize, I was really surprised on which 
> headers gets utilized and which ones didn't.. I have it down to the bare 
> minimums in my script.
> 
> As far as glibc goes, from my people who are helping me the alpha 
> architecture is the culprit there.
> 
> Do we have a list of what headers are "user-space" and which ones should 
> not be "user-space"?
> 
> Also David W, let me know what I can do to help you out, a lot of people 
> on my end want to get this working properly.
> 
> Who's maintaining util-linux these days, we probably should get a patch 
> to them.

  Adrian Bunk <bunk@stusta.de>


---
~Randy
