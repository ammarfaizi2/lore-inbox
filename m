Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVBWJAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVBWJAm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 04:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVBWJAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 04:00:42 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:33430 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261434AbVBWJAh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 04:00:37 -0500
Date: Wed, 23 Feb 2005 09:59:21 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jdmason@us.ibm.com,
       rich@phekda.gotadsl.co.uk, jgarzik@pobox.com
Subject: Re: [rft/update] r8169 changes in 2.6.x
Message-ID: <20050223085921.GA22268@electric-eye.fr.zoreil.com>
References: <20050222234810.GA17303@electric-eye.fr.zoreil.com> <20050222172935.30e43270.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222172935.30e43270.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> :
> There are already a bunch of r8169 patches in Jeff's tree.  The combination
> isn't pretty:
[removed by parental advisory]

I sent r8169-4{0/1/2/3/4}0 on netdev + Jeff the 22/02/2005. Jeff's netdev
(thus your tree) already had the r8169-3xx changes.

Jeff has acked r8169-4{0/1/2/3}0 on 23/02/2005. r8169-440 (PCI-ID) won't
be applied (there should be no functionnal change nor merge side-effect).

r8169-4{5/6}0 have been published only here (so far).

So you can:
- apply r8169-4{0/1/2/3/5/6}0 if you have not updated to Jeff -netdev beyond
  what is currently available through plain old patch
- apply r8169-4{5/6}0 if you are bk-synced with Jeff -netdev (assuming that
  Jeff acked after he actually pushed to its bk repo)
- do something else until I verify the above and generate a dedicated
  patchsets for your tree.

--
Ueimor
