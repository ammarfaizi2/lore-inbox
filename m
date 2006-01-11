Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWAKRT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWAKRT4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWAKRT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:19:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15307 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751533AbWAKRTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:19:55 -0500
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
From: Arjan van de Ven <arjan@infradead.org>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com
In-Reply-To: <43C53DA0.60704@us.ibm.com>
References: <43C53DA0.60704@us.ibm.com>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 18:19:46 +0100
Message-Id: <1136999987.2929.63.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 12:17 -0500, Mike D. Day wrote:
> The included patch provides some sysfs helper routines so that xen 
> domain kernel processes can easily attributes to sysfs. The intent is 
> that any kernel process can add an attribute under /sys/xen just as 
> easily as adding a file under /proc. In other words, without using the 
> driver core to create a subsystem, dealing with kobjects and ksets, etc.


eh... WHY ???

so that sys gets just as much of a mess as proc already is, so that
there are 2 messes????? 


