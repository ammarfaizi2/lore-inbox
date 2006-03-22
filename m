Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWCVT2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWCVT2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWCVT2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:28:04 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:1746 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932413AbWCVT2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:28:02 -0500
Subject: Re: [GIT PATCH] pending SCSI updates for post 2.6.16
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603221048210.26286@g5.osdl.org>
References: <1142956795.4377.19.camel@mulgrave.il.steeleye.com>
	 <20060322083647.cc0ccdd4.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0603221048210.26286@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 13:27:07 -0600
Message-Id: <1143055627.3629.1.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 10:49 -0800, Linus Torvalds wrote:
> Just something like this? Or did you have something else in mind?
> 
> (Pls test and ack).

That and a comment telling those who come after to keep scsi_debug at
the bottom of the driver list, I think, thanks.

James


