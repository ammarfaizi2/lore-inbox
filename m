Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUIDOpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUIDOpo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 10:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUIDOpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 10:45:44 -0400
Received: from main.gmane.org ([80.91.224.249]:29874 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262062AbUIDOpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 10:45:42 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [PATCH] use KERNELRELEASE
Date: Sat, 04 Sep 2004 23:45:37 +0900
Message-ID: <chckei$n6q$1@sea.gmane.org>
References: <4139A443.4080704@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
In-Reply-To: <4139A443.4080704@quark.didntduck.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> This patch changes several places where the kernel version string is put 
> together from it's components with $KERNELRELEASE.

Cool! I guess that is further fix for the 2.6.8.1 thing :-)

Now we should look into things like VMware and nVidia drivers and their Makefiles...

Please use the Signed-off-by format.
(i.e. add:

   Signed-off-by: Brian Gerst <bgerst@quark.didntduck.org>

before the patches you send)

Kalin.

-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

