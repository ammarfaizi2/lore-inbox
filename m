Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUDLEcx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 00:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUDLEcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 00:32:53 -0400
Received: from mailhub.hp.com ([192.151.27.10]:50630 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S262730AbUDLEcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 00:32:51 -0400
Subject: Re: [ACPI] Re: [PATCH] filling in ACPI method access via sysfs  
	namespace
From: Alex Williamson <alex.williamson@hp.com>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Matthew Wilcox <willy@debian.org>, John Belmonte <john@neggie.net>,
       acpi-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <407A1787.5060508@myrealbox.com>
References: <fa.n5srcao.1k1orra@ifi.uio.no> <fa.e0sva3e.u5k09i@ifi.uio.no>
	 <407A1787.5060508@myrealbox.com>
Content-Type: text/plain
Message-Id: <1081744367.1715.30.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 11 Apr 2004 22:32:48 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-04-11 at 22:13, Andy Lutomirski wrote:

> Is there any reason this shouldn't be an ioctl?
> 

   See the thread John pointed me to on Friday:

http://sourceforge.net/mailarchive/message.php?msg_id=7455349

Matthew ended it with "sysfs does not support ioctls.  case closed." 
I'm rather fond of the methods living in the sysfs directory
structure...

	Alex

