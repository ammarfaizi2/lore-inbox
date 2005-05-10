Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVEJUbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVEJUbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVEJUbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:31:36 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:4270 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261778AbVEJUbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:31:01 -0400
Date: Tue, 10 May 2005 13:30:56 -0700
From: Greg KH <gregkh@suse.de>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: James Chapman <jchapman@katalix.com>, Jean Delvare <khali@linux-fr.org>,
       LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: Re: [PATCH] ds1337: export ds1337_do_command
Message-ID: <20050510203056.GA3415@suse.de>
References: <20050504061438.GD1439@orphique> <1DTwF8-18P-00@press.kroah.org> <20050508204021.627f9cd1.khali@linux-fr.org> <427E6E21.60001@katalix.com> <20050508222351.08bfe2e1.khali@linux-fr.org> <20050510121814.GB2492@orphique> <20050510175549.GC1530@suse.de> <20050510183651.GA10720@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510183651.GA10720@orphique>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 08:36:51PM +0200, Ladislav Michl wrote:
> And while you bring up license issue, comment on top of file says GPL
> version 2, but MODULE_LICENSE is set to GPL.

That is correct.

thanks,

greg k-h
