Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbTGHTgP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 15:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267521AbTGHTgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 15:36:15 -0400
Received: from [195.82.120.238] ([195.82.120.238]:37591 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S265285AbTGHTgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 15:36:15 -0400
Date: Tue, 8 Jul 2003 20:53:25 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>
Subject: Re: Tainted: S
Message-ID: <20030708195325.GA2673@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Nigel Cunningham <ncunningham@clear.net.nz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	swsusp-devel <swsusp-devel@lists.sourceforge.net>
References: <1057692128.14471.10.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057692128.14471.10.camel@laptop-linux>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 07:22:08AM +1200, Nigel Cunningham wrote:
 > With the latest prepatch for the 2.4 version of swsusp, I've made swsusp
 > taint the kernel upon resume from a suspend-to-disk. Any oopses that
 > occur afterwards will contain S as a third character (eg PFS).
 
2.5 already uses 'S' to mark "out-of-spec SMP system".

		Dave

