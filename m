Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWCVQek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWCVQek (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWCVQej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:34:39 -0500
Received: from xenotime.net ([66.160.160.81]:42446 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751356AbWCVQej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:34:39 -0500
Date: Wed, 22 Mar 2006 08:36:47 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [GIT PATCH] pending SCSI updates for post 2.6.16
Message-Id: <20060322083647.cc0ccdd4.rdunlap@xenotime.net>
In-Reply-To: <1142956795.4377.19.camel@mulgrave.il.steeleye.com>
References: <1142956795.4377.19.camel@mulgrave.il.steeleye.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006 09:59:55 -0600 James Bottomley wrote:

> This is the set of all the changes I've accumulated since 2.6.16 went
> -rc.  I'm afraid its pretty hefty (another qla firmware update ... but
> at least the built in firmware is now deprecated and we're moving to the
> firmware loader interface)
> 
> The patch is available from
> 
> master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git

Can we get a SCSI_DEBUG link order change (or force it to not
built-in)?

---
~Randy
