Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbVDAK0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVDAK0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 05:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbVDAK0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 05:26:18 -0500
Received: from rev.193.226.232.24.euroweb.hu ([193.226.232.24]:18357 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262689AbVDAK0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 05:26:15 -0500
To: rddunlap@osdl.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <424C7016.5050404@osdl.org> (rddunlap@osdl.org)
Subject: Re: build logs for -mm
References: <E1DH7KJ-00023v-00@dorka.pomaz.szeredi.hu> <424C7016.5050404@osdl.org>
Message-Id: <E1DHJLZ-00039U-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Apr 2005 12:25:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > do I believe correctly that you do automatic builds of -mm for lots of
> > architectures?  If yes, is there some place where the output is
> > available?  This would be useful for fixing warnings.
> 
> The OSDL PLM tool also does automated builds of all -linus
> and -mm releases.  2.6.12-rc1-mm4 results are here:
> 
> http://www.osdl.org/plm-cgi/plm?module=patch_info&patch_id=4352

Thanks.  I see that for most architectures this only builds a
defconfig kernel, which is not useful for projects not included in
defconfig.

Would it be too much load for the server to handle a full config for
all archs?

Thanks,
Miklos
