Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWI2KUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWI2KUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 06:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWI2KUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 06:20:44 -0400
Received: from main.gmane.org ([80.91.229.2]:42449 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751075AbWI2KUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 06:20:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [ACRYPTO] New asynchronous crypto layer (acrypto) release.
Date: 29 Sep 2006 12:17:58 +0200
Message-ID: <87wt7nm0x5.fsf@willow.rfc1149.net>
References: <20060928120826.GA18063@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: zaphod.rfc1149.net
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
X-Leafnode-NNTP-Posting-Host: 2001:6f8:37a:2::2
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Evgeniy" == Evgeniy Polyakov <johnpol@2ka.mipt.ru> writes:

Evgeniy> Hello.  I'm pleased to announce asynchronous crypto layer
Evgeniy> (acrypto) [1] release for 2.6.18 kernel tree. Acrypto allows
Evgeniy> to handle crypto requests asynchronously in hardware.

Would userspace programs benefit from this patch? In particular, would
OpenSSL get better performances on Via nehemiah CPUs or does it need
to be patched?

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/

