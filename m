Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbUCUD1j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 22:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbUCUD1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 22:27:39 -0500
Received: from fmr05.intel.com ([134.134.136.6]:22959 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263594AbUCUD1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 22:27:38 -0500
Subject: Re: ACPI IRQ routing problems with Thinkpad T40
From: Len Brown <len.brown@intel.com>
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@bitplanet.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F5EEF@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F5EEF@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1079839652.7279.845.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 Mar 2004 22:27:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been trying to track down a problem where an interrupt from a
> cardbus card is being routed incorrectly.

Kristian,
Please test the "proposed final patch" here:

http://bugzilla.kernel.org/show_bug.cgi?id=1564

thanks,
-Len


