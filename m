Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUGBQ1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUGBQ1i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264702AbUGBQ0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:26:38 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:38815 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263085AbUGBQY4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:24:56 -0400
Date: Fri, 2 Jul 2004 11:24:12 -0500
From: linas@austin.ibm.com
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 2.6 remove deprecated firmware API
Message-ID: <20040702112412.P21634@forte.austin.ibm.com>
References: <20040701175348.L21634@forte.austin.ibm.com> <16612.40814.708938.269154@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16612.40814.708938.269154@cargo.ozlabs.ibm.com>; from paulus@samba.org on Fri, Jul 02, 2004 at 09:34:06AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 09:34:06AM +1000, Paul Mackerras wrote:
> linas@austin.ibm.com writes:
> 
> > This patch eliminates the usage of the deprecated ibm,fw-phb-id 
> > token for idnetifying PCI bus heads in favor of the documented, 
> > offically supported mechanism for obtaining this info.  Please 
> > note that some versions of firmware may return incorrect values 
> > for the ibm,fw-phb-id token.
> 
> Looks good, could I have a Signed-off-by line for it please?

Oops sorry,
Iwrote the entire patch ... 

Signed-off-by: Linas Vepstas <linas@linas.org>


