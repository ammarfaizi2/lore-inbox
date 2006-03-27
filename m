Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWC0NMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWC0NMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 08:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWC0NMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 08:12:47 -0500
Received: from [202.125.80.81] ([202.125.80.81]:8636 "EHLO rocsys.com")
	by vger.kernel.org with ESMTP id S1750996AbWC0NMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 08:12:47 -0500
X-MessageWall-Score: 0 (rocsys.com)
Message-ID: <4427E967.4050101@rocsys.com>
Date: Mon, 27 Mar 2006 19:02:23 +0530
From: kaushal <kaushal@rocsys.com>
User-Agent: Mozilla Thunderbird M6 (Windows/20040405)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ISDN hisax hfc_pci big endian port
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,
         Can someone share the big endian port for the PCI ISDN card 
driver ?Currently it prints the statement:

#*error* "not running on *big endian* machines now"

This line is present in drivers/isdn/hisax/hfc_pci.c

If the port is not available can someone suggest/show pointers for the 
guidelines to port for bigendian.
Thanks in advance.

cheers-
kaushal.


