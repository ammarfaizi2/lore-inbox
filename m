Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbUCKGsU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 01:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbUCKGsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 01:48:20 -0500
Received: from fmr01.intel.com ([192.55.52.18]:34756 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262789AbUCKGsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 01:48:18 -0500
Subject: Re: 2.6.3: VIA+ACPI+yenta->hang
From: Len Brown <len.brown@intel.com>
To: Mark Hindley <mark@hindley.uklinux.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F4B49@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F4B49@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1078987693.2555.81.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Mar 2004 01:48:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-10 at 06:42, Mark Hindley wrote:
> Hi,
> 
> I am doing a new install of 2.6.3 on an Acer 1353XV.
> 
> If I have anything more than acpi=ht loading yenta_socket causes a
> hang
> requiring hard reset.

Mark,
Please test the patch here:

http://bugzilla.kernel.org/show_bug.cgi?id=1564

thanks,
-Len


