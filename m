Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967754AbWK3AxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967754AbWK3AxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 19:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967755AbWK3AxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 19:53:12 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:48877
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S967754AbWK3AxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 19:53:08 -0500
Date: Wed, 29 Nov 2006 16:53:11 -0800 (PST)
Message-Id: <20061129.165311.45739865.davem@davemloft.net>
To: wenji@fnal.gov
Cc: netdev@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
From: David Miller <davem@davemloft.net>
In-Reply-To: <HNEBLGGMEGLPMPPDOPMGGEAKCGAA.wenji@fnal.gov>
References: <HNEBLGGMEGLPMPPDOPMGCEAKCGAA.wenji@fnal.gov>
	<HNEBLGGMEGLPMPPDOPMGGEAKCGAA.wenji@fnal.gov>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please, it is very difficult to review your work the way you have
submitted this patch as a set of 4 patches.  These patches have not
been split up "logically", but rather they have been split up "per
file" with the same exact changelog message in each patch posting.
This is very clumsy, and impossible to review, and wastes a lot of
mailing list bandwith.

We have an excellent file, called Documentation/SubmittingPatches, in
the kernel source tree, which explains exactly how to do this
correctly.

By splitting your patch into 4 patches, one for each file touched,
it is impossible to review your patch as a logical whole.

Please also provide your patch inline so people can just hit reply
in their mail reader client to quote your patch and comment on it.
This is impossible with the attachments you've used.

Thanks.
