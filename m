Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263564AbUEMOkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUEMOkS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 10:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUEMOkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 10:40:18 -0400
Received: from ms001msg.fastwebnet.it ([213.140.2.51]:34006 "EHLO
	ms001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S263564AbUEMOkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 10:40:13 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: 2.6.6-mm2: bk-driver-core-module-fix.patch no longer required
Date: Thu, 13 May 2004 16:36:24 +0200
User-Agent: KMail/1.6.2
References: <20040513032736.40651f8e.akpm@osdl.org> <200405131542.23710.ornati@fastwebnet.it> <20040513140102.GE22202@fs.tum.de>
In-Reply-To: <20040513140102.GE22202@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405131636.24383.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 May 2004 16:01, you wrote:
> On Thu, May 13, 2004 at 03:42:23PM +0200, Paolo Ornati wrote:
> >
> >   CC      kernel/module.o
> > kernel/module.c:730: error: redefinition of `add_attribute'
> > kernel/module.c:382: error: `add_attribute' previously defined here
> > kernel/module.c:382: warning: `add_attribute' defined but not used
> > make[1]: *** [kernel/module.o] Error 1
> > make: *** [kernel] Error 2
>
> bk-driver-core-module-fix.patch is no longer required (a different fix
> is in bk-driver-core.patch).
>
> Simply _revert_ the patch below.

OK

bye

-- 
	Paolo Ornati
	Linux v2.6.6
