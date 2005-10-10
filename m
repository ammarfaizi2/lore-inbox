Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVJJAeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVJJAeO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 20:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVJJAeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 20:34:13 -0400
Received: from jp.dhs.org ([213.84.189.153]:6332 "EHLO debian.jp.dhs.org")
	by vger.kernel.org with ESMTP id S932316AbVJJAeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 20:34:13 -0400
From: Jan Pieter <pptp@jp.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: Common symbol support for 2.6 modules
Date: Mon, 10 Oct 2005 02:34:10 +0200
User-Agent: KMail/1.8.2
Cc: pptp@jp.dhs.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510100234.10419.pptp@jp.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm building a 2.6 kernel module from an object file that is compiled
without -fno-common. I have no source from that object file, so I can
not recompile it. Does someone have a patch to include common symbol
support in 2.6 kernels? Or can someone tell me in which kernel that
support has been first taken out? Or have the patch that removed the
support for common symbols?

Thank you.


Jan Pieter. 
