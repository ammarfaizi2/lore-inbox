Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262853AbVCDBNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbVCDBNk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbVCDBJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 20:09:39 -0500
Received: from fire.osdl.org ([65.172.181.4]:64734 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262837AbVCDBH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 20:07:56 -0500
Date: Thu, 3 Mar 2005 17:07:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: roland@topspin.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][26/26] IB: MAD cancel callbacks
 fromthread
Message-Id: <20050303170752.7bc42e86.akpm@osdl.org>
In-Reply-To: <20050303170109.72e8a3f2.akpm@osdl.org>
References: <ORSMSX401FRaqbC8wSA0000000e@orsmsx401.amr.corp.intel.com>
	<52fyzcnsup.fsf@topspin.com>
	<20050303170109.72e8a3f2.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Roland Dreier <roland@topspin.com> wrote:
> >
> >     >> don't add casts to a void pointer, that's silly.
> > 
> > How should we handle this nit?  Should I post a new version of this
> > patch or an incremental diff that fixes it up?
> > 
> 
> I'll fix it up.

Actually, seeing as 15/26 has vanished into the ether and there have been
quite a few comments, please resend everything.
