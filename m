Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUGEVUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUGEVUl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 17:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUGEVUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 17:20:41 -0400
Received: from fmr02.intel.com ([192.55.52.25]:22433 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S261857AbUGEVUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 17:20:40 -0400
Subject: Re: System not booting after acpi_power_off()
From: Len Brown <len.brown@intel.com>
To: Joerg Sommrey <jo@sommrey.de>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040705210420.GA23177@sommrey.de>
References: <A6974D8E5F98D511BB910002A50A6647615FF35A@hdsmsx403.hd.intel.com>
	 <1089059128.15675.77.camel@dhcppc4>  <20040705210420.GA23177@sommrey.de>
Content-Type: text/plain
Organization: 
Message-Id: <1089062436.15675.128.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Jul 2004 17:20:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, I don't see any messages from the button driver,
do you have CONFIG_ACPI_BUTTON enabled?
If yes, can you send me the output
from acpidmp?  acpidmp is in /usr/sbin
or in pmtools: 
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

thanks,
-Len



