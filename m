Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030469AbWBNF6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbWBNF6Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbWBNF6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:58:25 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:17362 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030428AbWBNF6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:58:24 -0500
Date: Tue, 14 Feb 2006 14:58:23 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: vatsa@in.ibm.com
Cc: Rajaram.Suryanarayanan@in.unisys.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, balbir.singh@in.ibm.com
Subject: Re: [ckrm-tech] [PATCH 1/2] add a CPU resource controller
In-Reply-To: <20060214053852.GD28942@in.ibm.com>
References: <88299102B8C1F54BB5C8E47F30B2FBE201E95CD2@inblr-exch1.eu.uis.unisys.com>
	<20060214052604.7EA9174031@sv1.valinux.co.jp>
	<20060214053852.GD28942@in.ibm.com>
X-Mailer: Sylpheed version 2.2.0beta8 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20060214055823.7AF1C7402D@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006 11:08:52 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> > It's not a forward port of the existing CPU resource controller 
> > but a new CPU resource controller for CKRM.  Its resource control
> > mechanism is different from that of the existing one.
> 
> Hmm ..I guess it depends on which version of CKRM you are referring when
> you say "existing". When I replied earlier, I was referring to f-series.
> f-series cpu controller is based on the patch you sent to lkml right?

Ah, I referred to the CKRM e- series controller as "existing controller"
and referred to the controller that I had sent as "a new CPU resource 
controller."

So, the controller that I had sent is the existing controller of
f- series.

Sorry for confusion,

-- 
KUROSAWA, Takahiro
