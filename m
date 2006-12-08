Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425389AbWLHLGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425389AbWLHLGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425390AbWLHLGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:06:45 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:39143 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425389AbWLHLGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:06:44 -0500
Date: Fri, 8 Dec 2006 12:04:57 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: lkml <linux-kernel@vger.kernel.org>, jesper.juhl@gmail.com,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH/v2] CodingStyle updates
In-Reply-To: <20061207165508.e6bf0269.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.61.0612081200040.20988@yvahk01.tjqt.qr>
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 7 2006 16:55, Randy Dunlap wrote:

>Date: Thu, 7 Dec 2006 16:55:08 -0800
>From: Randy Dunlap <randy.dunlap@oracle.com>
>To: lkml <linux-kernel@vger.kernel.org>
>Cc: jesper.juhl@gmail.com, akpm <akpm@osdl.org>
>Subject: [PATCH/v2] CodingStyle updates
>
>From: Randy Dunlap <randy.dunlap@oracle.com>
>
>Add some kernel coding style comments, mostly pulled from emails
>by Andrew Morton, Jesper Juhl, and Randy Dunlap.
>
>- add paragraph on switch/case indentation (with fixes)
>- add paragraph on multiple-assignments
>- add more on Braces
>- add section on Spaces; add typeof, alignof, & __attribute__ with sizeof;
>  add more on postfix/prefix increment/decrement operators
>- add paragraph on function breaks in source files; add info on
>  function prototype parameter names
>- add paragraph on EXPORT_SYMBOL placement
>- add section on /*-comment style, long-comment style, and data
>  declarations and comments
>- correct some chapter number references that were missed when
>  chapters were renumbered
>
>Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
>Acked-by: Jesper Juhl <jesper.juhl@gmail.com>

Acked-by: Jan Engelhardt <jengelh@gmx.de>

	-`J'
-- 
