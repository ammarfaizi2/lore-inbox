Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbULIAvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbULIAvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 19:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbULIAvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 19:51:16 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:2722 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261358AbULIAvO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 19:51:14 -0500
Date: Thu, 9 Dec 2004 01:50:15 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Nicholas Papadakos <panic@quake.gr>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: realtek r8169 + kernel 2.4.24 (openmosix)
Message-ID: <20041209005015.GA25868@electric-eye.fr.zoreil.com>
References: <20041205122414.GA22383@electric-eye.fr.zoreil.com> <200412051317.iB5DHrOL026570@kane.otenet.gr> <20041205135132.GA23262@electric-eye.fr.zoreil.com> <20041206234131.GA12838@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041206234131.GA12838@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> :
[unstable backport of the r8169 driver]

Nicholas, can you give a try at the patch below against vanilla 2.4.28 ?
http://www.fr.zoreil.com/people/francois/misc/20041209-2.4.28-r8169.c-test.patch

This patch does not trivially crash and you should be able to set the
mtu around 7200 bytes.

The detail of the (43) patches is available at:
http://www.fr.zoreil.com/linux/kernel/2.4.x/2.4.28/r8169.

--
Ueimor
