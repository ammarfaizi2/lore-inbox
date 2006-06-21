Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWFUOPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWFUOPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWFUOPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:15:20 -0400
Received: from [212.70.37.162] ([212.70.37.162]:43784 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751012AbWFUOPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:15:20 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_VGACON_SOFT_SCROLLBACK crashes 2.6.17
Date: Wed, 21 Jun 2006 17:15:58 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200606211715.58773.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Enabling CONFIG_VGACON_SOFT_SCROLLBACK causes random fatal system freezes.

Especially, ping 10.1 -A easily causes a complete system hang during scroll.

Is there an easy way to fix this, other than disabling the option?

Thanks!

--
Al

