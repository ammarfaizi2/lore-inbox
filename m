Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbUKIGDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUKIGDC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 01:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbUKIGBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 01:01:40 -0500
Received: from motgate8.mot.com ([129.188.136.8]:21634 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S261411AbUKIFsO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:48:14 -0500
In-Reply-To: <20041108213428.16dfb1f7.akpm@osdl.org>
References: <20041108213428.16dfb1f7.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <EA4FB805-3212-11D9-AC65-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: <linux-kernel@vger.kernel.org>, "Kumar Gala" <galak@somerset.sps.mot.com>,
       <linuxppc-embedded@ozlabs.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH][PPC32] Added MPC8555/8541 security block infrastructure
Date: Mon, 8 Nov 2004 23:48:00 -0600
To: "Andrew Morton" <akpm@osdl.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uugh, sorry.  The previous version of pine I was using did not do this. 
  I will look at trying to change its settings.  Thanks for reformatting 
the patch.  Can you explain further what you mean by 'space-stuffing'

thanks

- kumar

On Nov 8, 2004, at 11:34 PM, Andrew Morton wrote:

> Kumar Gala <galak@somerset.sps.mot.com> wrote:
>  >
>  > This patch adds OCP, interrupt, and memory offset details for the 
> security
> >  block on MPC8555/8541 to support drivers.
>
> Your email client did space-stuffing on the message, so the patch gets 
> 100%
>  rejects.  I fixed it up by hand and applied the patch locally, thanks.
>
> I think there's a way of telling Pine to stop doing this.

