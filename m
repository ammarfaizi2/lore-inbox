Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUGAXdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUGAXdx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 19:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266365AbUGAXdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 19:33:53 -0400
Received: from ozlabs.org ([203.10.76.45]:34988 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266250AbUGAXdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 19:33:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16612.40814.708938.269154@cargo.ozlabs.ibm.com>
Date: Fri, 2 Jul 2004 09:34:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 2.6 remove deprecated firmware API
In-Reply-To: <20040701175348.L21634@forte.austin.ibm.com>
References: <20040701175348.L21634@forte.austin.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linas@austin.ibm.com writes:

> This patch eliminates the usage of the deprecated ibm,fw-phb-id 
> token for idnetifying PCI bus heads in favor of the documented, 
> offically supported mechanism for obtaining this info.  Please 
> note that some versions of firmware may return incorrect values 
> for the ibm,fw-phb-id token.

Looks good, could I have a Signed-off-by line for it please?

Thanks,
Paul.
