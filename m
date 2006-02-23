Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWBWX0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWBWX0U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 18:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWBWX0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 18:26:19 -0500
Received: from smtp13.wanadoo.fr ([193.252.22.54]:41696 "EHLO
	smtp13.wanadoo.fr") by vger.kernel.org with ESMTP id S932124AbWBWX0T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 18:26:19 -0500
X-ME-UUID: 20060223232618138.21BC8700008F@mwinf1307.wanadoo.fr
Date: Fri, 24 Feb 2006 00:26:14 +0100
From: Vincent Kergonna <vincent.kergonna@wanadoo.fr>
To: Asfand Yar Qazi <email@asfandyar.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changing the scheduler at runtime
Message-Id: <20060224002614.00c514bc.vincent.kergonna@wanadoo.fr>
In-Reply-To: <43FE0872.4080807@asfandyar.cjb.net>
References: <43FE0872.4080807@asfandyar.cjb.net>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.11; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006 19:09:38 +0000
Asfand Yar Qazi <email@asfandyar.cjb.net> wrote:

> Hi,
> 
> I compiled all the schedulers into the kernel - but I can't find how to change
> the one to be used at runtime.  Can you help me?  Or can it only be set at
> boot-time (in which case, how?)  Thanks.

Here is the answer you are looking for: http://kerneltrap.org/node/3851

> 
> Thanks
> 
> -- 
> To reply, take of all ZIGs !!
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

