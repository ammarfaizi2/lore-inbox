Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265382AbTLRW6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 17:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265386AbTLRW6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 17:58:16 -0500
Received: from bifrost.vividimage.com ([207.158.2.66]:65436 "EHLO
	bifrost.vividimage.com") by vger.kernel.org with ESMTP
	id S265382AbTLRW6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 17:58:14 -0500
From: Kent Whitten <kent@vividimage.com>
Organization: Vivid Image Technology
To: linux-kernel@vger.kernel.org
Subject: Problem with i386 build
Date: Thu, 18 Dec 2003 14:57:10 -0800
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312181457.11056.kent@vividimage.com>
X-Filter-Version: 1.11aala2 (bifrost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Makefile in arch/i386/mach-default has a -I../kernel in it.  I had a file 
called kernel sitting next to linux-2.6.0, and gcc died with ../kernel is not 
a directory.

Congrats on a big victory!

kent
