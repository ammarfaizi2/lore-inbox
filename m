Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWBJLyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWBJLyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 06:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWBJLyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 06:54:41 -0500
Received: from mail.dvmed.net ([216.237.124.58]:15296 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751087AbWBJLyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 06:54:40 -0500
Message-ID: <43EC7EFB.5020100@pobox.com>
Date: Fri, 10 Feb 2006 06:54:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: libata janitor project
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.6 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Long term, we should work to replace the assert() in
	libata with standard kernel WARN_ON(). If someone wanted to handle that
	conversion, that would be useful. Make sure to pay attention, the sense
	of each test must be reversed. [...] 
	Content analysis details:   (0.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 TO_ADDRESS_EQ_REAL     To: repeats address as real name
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Long term, we should work to replace the assert() in libata with 
standard kernel WARN_ON().

If someone wanted to handle that conversion, that would be useful.  Make 
sure to pay attention, the sense of each test must be reversed.

	Jeff



