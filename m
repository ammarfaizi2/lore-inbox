Return-Path: <linux-kernel-owner+w=401wt.eu-S932367AbXAISqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbXAISqL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbXAISqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:46:11 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60736 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932355AbXAISqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:46:09 -0500
Date: Tue, 9 Jan 2007 10:45:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, NetDev <netdev@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH -MM] e1000: rewrite hardware initialization code
Message-Id: <20070109104525.b0f17316.akpm@osdl.org>
In-Reply-To: <45A3D29D.1000202@intel.com>
References: <45A3D29D.1000202@intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jan 2007 09:36:29 -0800
Auke Kok <auke-jan.h.kok@intel.com> wrote:

>      git-pull git://lost.foo-projects.org/~ahkok/git/linux-2.6 e1000

That tree appears to be based on the -mm git tree?

That's a somewhat unusual thing to do - a tree which is based on current
Linus mainline would be preferred, please.  Or on Jeff's netdev tree.

Thanks.
