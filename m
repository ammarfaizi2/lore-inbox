Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUBTFLG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 00:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267541AbUBTFLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 00:11:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43196 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267479AbUBTFLC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 00:11:02 -0500
Message-ID: <403596D8.8020509@pobox.com>
Date: Fri, 20 Feb 2004 00:10:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Wagland <paul@kungfoocoder.org>
CC: Linux SCSI mailing list <linux-scsi@vger.kernel.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       torvalds@osdl.org, James.Bottomley@HansenPartnership.com,
       atulm@lsil.com
Subject: Re: [PATCH][BUGFIX] : Megaraid patch for 2.6 1/5
References: <1077242738.12567.76.camel@morsel.kungfoocoder.org>
In-Reply-To: <1077242738.12567.76.camel@morsel.kungfoocoder.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 1-5 look OK to me.

If you are attempting to follow LSI's megaraid (in 2.4 only, sigh), 
patch #4 may wind up causing you grief in the future.  Hopefully Atul 
will pick it up, though :)

	Jeff




