Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUDMU5J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 16:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263748AbUDMU5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 16:57:08 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:36483 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263743AbUDMU5G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 16:57:06 -0400
Date: Tue, 13 Apr 2004 21:54:08 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Daniel Egger <degger@fhm.edu>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Netdev <netdev@oss.sgi.com>
Subject: Re: [NET] net driver updates
Message-ID: <20040413215408.A8741@electric-eye.fr.zoreil.com>
References: <4072CD01.6070408@pobox.com> <FE87A41F-8809-11D8-8F2A-000A9597297C@fhm.edu> <407C31F4.9070800@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <407C31F4.9070800@pobox.com>; from jgarzik@pobox.com on Tue, Apr 13, 2004 at 02:31:16PM -0400
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> :
[...]
> Francois is still trying to fix all the vendor-created bugs, so 
> performance is a secondary consideration.

With due respect to Realtek and others, some pesky bugs in the driver
were really (c) by me.

The issues related to 64 bit host and/or link recovery seem to be gone.

If people experience issues with the r8169 driver in -mm/-netdev whereas
the vanilla driver works fine, I am interested to hear from them.
Preferably now.

--
Ueimor
