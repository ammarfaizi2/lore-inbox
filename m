Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272788AbTG3GhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 02:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272785AbTG3Gfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 02:35:48 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:21173 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S272783AbTG3Gfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 02:35:44 -0400
Date: Wed, 30 Jul 2003 16:36:57 +1000
From: CaT <cat@zip.com.au>
To: Philip Graham Willoughby <pgw99@doc.ic.ac.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030730063657.GH1395@zip.com.au>
References: <20030729151701.GA6795@bodmin.doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729151701.GA6795@bodmin.doc.ic.ac.uk>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 04:17:03PM +0100, Philip Graham Willoughby wrote:
> Hi all,
> 
> This patch adds an abstraction layer for programmable LED devices,

Would this (now or in the future) by any chance let one use the keyboard
leds for stuff without activating their num lock, caps lock and scroll
lock functionality? I'd like to use one of them (at least) as a network
traffic indicator but so far I get the sideffects of the functionality
being on also. Most annoying when typing. :/

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
