Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVDCSGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVDCSGs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 14:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVDCSGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 14:06:48 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:41124 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261548AbVDCSGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 14:06:47 -0400
X-ORBL: [69.107.61.180]
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: Re: fix u32 vs. pm_message_t in usb
Date: Sun, 3 Apr 2005 10:06:41 -0800
User-Agent: KMail/1.7.1
Cc: pavel@ucw.cz
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504031106.41639.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, please do NOT apply this.  It conflicts with other
patches, which have been in the past few MM releases, have
also been circulated on linux-usb-devel, and actually address
some of the bugs which crept in as things have changed around
the USB stack.

- Dave
