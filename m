Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWEAJnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWEAJnh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 05:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWEAJnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 05:43:37 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:59310 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750985AbWEAJng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 05:43:36 -0400
Subject: Re: IP1000 gigabit nic driver
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: David Vrabel <dvrabel@cantab.net>
Cc: romieu@fr.zoreil.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       david@pleyades.net
In-Reply-To: <44554ADE.8030200@cantab.net>
References: <20060427142939.GA31473@fargo>
	 <20060427185627.GA30871@electric-eye.fr.zoreil.com>
	 <445144FF.4070703@cantab.net> <20060428075725.GA18957@fargo>
	 <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com>
	 <20060428113755.GA7419@fargo>
	 <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI>
	 <1146306567.1642.3.camel@localhost>  <20060429122119.GA22160@fargo>
	 <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost>
	 <44554ADE.8030200@cantab.net>
Date: Mon, 01 May 2006 12:43:34 +0300
Message-Id: <1146476614.11271.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 00:40 +0100, David Vrabel wrote:
> Still pending.  Also:
> 
>      - something (PHY reset/auto negotiation?) takes 2-3 seconds and
>        appears to be done with interrupts disabled.

Are you seeing this at module initialization? Does Sysrq-t show anything
useful?

					Pekka

