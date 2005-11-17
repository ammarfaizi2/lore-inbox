Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbVKQAKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbVKQAKd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbVKQAKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:10:33 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:51676 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030568AbVKQAKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:10:31 -0500
Subject: Re: 2.6.14 X spinning in the kernel
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Dave Airlie <airlied@linux.ie>
Cc: Max Krasnyansky <maxk@qualcomm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, hugh@veritas.com
In-Reply-To: <Pine.LNX.4.58.0511162238480.24969@skynet>
References: <1132012281.24066.36.camel@localhost.localdomain>
	 <20051114161704.5b918e67.akpm@osdl.org>
	 <1132015952.24066.45.camel@localhost.localdomain>
	 <20051114173037.286db0d4.akpm@osdl.org> <437A6609.4050803@us.ibm.com>
	 <437B9FAC.4090809@qualcomm.com>
	 <1132177953.24066.80.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0511162238480.24969@skynet>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 16:10:23 -0800
Message-Id: <1132186223.24066.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Can you send me lspci -v, /var/log/Xorg.0.log, xorg.conf
> 
> If you are running a PCI Radeon you are screwed with the latest Fedora X
> packages, roll back a few to find the ones that work, the FC people took a
> really hacky patch from ATI and thought it was a good idea, and now it is
> in X.org, or turn off DRI...

I turned off DRI for now and X is happy.

Thanks,
Badari

