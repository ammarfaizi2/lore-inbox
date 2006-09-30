Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWI3Duy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWI3Duy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 23:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWI3Duy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 23:50:54 -0400
Received: from [198.99.130.12] ([198.99.130.12]:45270 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750729AbWI3Duy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 23:50:54 -0400
Date: Fri, 29 Sep 2006 23:49:20 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Ollie Wild <aaw@google.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, dhollis@davehollis.com,
       Jason Lunz <lunz@falooley.org>
Subject: Re: [PATCH 2/2] UML - Don't roll my own random MAC generator
Message-ID: <20060930034920.GA10307@ccure.user-mode-linux.org>
References: <200609281814.k8SIEsG8005226@ccure.user-mode-linux.org> <65dd6fd50609291518s129786fbt1739c80533d1a36@mail.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65dd6fd50609291518s129786fbt1739c80533d1a36@mail.google.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 03:18:52PM -0700, Ollie Wild wrote:
> This patch as provided breaks my build due to a missing semicolon.
> 
> Patch attached.

Thanks - I fixed that, but forgot to refresh the patch.

				Jeff
