Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVEKSKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVEKSKB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 14:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVEKSKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 14:10:00 -0400
Received: from 205.41.76.83.cust.bluewin.ch ([83.76.41.205]:61771 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S261226AbVEKSJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 14:09:45 -0400
Date: Wed, 11 May 2005 20:07:22 +0200
From: Karel Kulhavy <clock@twibright.com>
To: James Simmons <jsimmons@pentafluge.infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PC speaker input device
Message-ID: <20050511180722.GB8937@kestrel.twibright.com>
References: <20050511153314.GA24815@kestrel> <Pine.LNX.4.56.0505111820200.32222@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0505111820200.32222@pentafluge.infradead.org>
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 06:21:05PM +0100, James Simmons wrote:
> 
> > Hello
> > 
> > PC speaker (CONFIG_INPUT_PCSPKR) is in kernel make menuconfig
> > 2.6.11-gentoo-r5 -> Device Drivers -> Input device support
> > 
> > PC speaker is output device. Why is output device in input device
> > submenu? Isn't this a mistake?
> 
> Some keyboards have built in speakers. 

" Say Y here if you want the standard PC Speaker to be used for bells
                             ^^^^^^^^^^^^^^^^^^^
and whistles.  "

Nono, it is no keyboard built-in speaker, it's standard PC speaker.

CL<
