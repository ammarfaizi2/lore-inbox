Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWBNF0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWBNF0I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbWBNF0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:26:07 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:8913 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030370AbWBNF0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:26:05 -0500
Date: Tue, 14 Feb 2006 14:26:04 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: "Suryanarayanan, Rajaram" <Rajaram.Suryanarayanan@in.unisys.com>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, balbir.singh@in.ibm.com
Subject: Re: [ckrm-tech] [PATCH 1/2] add a CPU resource controller
In-Reply-To: <88299102B8C1F54BB5C8E47F30B2FBE201E95CD2@inblr-exch1.eu.uis.unisys.com>
References: <88299102B8C1F54BB5C8E47F30B2FBE201E95CD2@inblr-exch1.eu.uis.unisys.com>
X-Mailer: Sylpheed version 2.2.0beta8 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20060214052604.7EA9174031@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 14 Feb 2006 10:30:13 +0530
"Suryanarayanan, Rajaram" <Rajaram.Suryanarayanan@in.unisys.com> wrote:

> Is this patch under discussion a new CPU resource controller for 2.6.15
> ?
> Or is it the modified version of the already existing resource
> controller for CKRM ?

It's not a forward port of the existing CPU resource controller 
but a new CPU resource controller for CKRM.  Its resource control
mechanism is different from that of the existing one.

> I just want to know if you are coming up with a different idea for CPU
> resource controller and whether we have choice between the existing
> resource controller and this new one ? 

If someone forward-ports the existing controller for CKRM f- version,
we will have a choice.

Regards,
-- 
KUROSAWA, Takahiro
