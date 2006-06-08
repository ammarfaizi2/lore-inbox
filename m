Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWFHAwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWFHAwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 20:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWFHAwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 20:52:22 -0400
Received: from [202.67.154.148] ([202.67.154.148]:21729 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S932513AbWFHAwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 20:52:21 -0400
Message-ID: <4487745C.8030000@ns666.com>
Date: Thu, 08 Jun 2006 02:50:36 +0200
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20060503 Debian
X-Accept-Language: en-us
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: kernel 2.6.16.17 and 2.6.16.20 high cpuload (90-100 %)
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Any one noticed a problem with sis chipsets and the above kernels
causing a high cpuload ? Every processes executed or pressing enter to
refresh top causes a huge cpu spike usually to 100 %.

The debian sarge distro kernel 2.4.27 works flawlessly.

Appreciate a few hints/advise i can check before diving into deeper waters.

Thank you !

Mark
