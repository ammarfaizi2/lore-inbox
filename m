Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265757AbUBRO5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 09:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUBRO5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 09:57:10 -0500
Received: from intra.cyclades.com ([64.186.161.6]:56471 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265757AbUBRO5I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 09:57:08 -0500
Date: Wed, 18 Feb 2004 12:51:15 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Security issues: upgrade to 2.4.25/2.6.3
Message-ID: <Pine.LNX.4.58L.0402181239040.28957@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

2.4.25 contains several security related fixes, including a fix for
another sys_mremap vulnerability. Upgrade to 2.4.25 for those who use
mainline kernels is recommended.

For those using distribution v2.4 kernels, the respective vendors should
release kernel updates soon.

For those using 2.6, upgrade to 2.6.3 is recommended.

More details about the issue will be available soon (if not already) by
complete security advisory by Paul Starzetz/CERT.
