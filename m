Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVB0FVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVB0FVX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 00:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVB0FVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 00:21:23 -0500
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:53921 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261348AbVB0FVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 00:21:22 -0500
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: LKML <linux-kernel@vger.kernel.org>
Subject: SELinux and sysfs
Date: Sun, 27 Feb 2005 00:21:24 -0500
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502270021.24252.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps in future, maybe SELinux could take advantage of sysfs to modify some 
policies? Is this doable?

Sure, we still need some flat files for static configurations, but what about 
dynamic ones?

Shawn.
