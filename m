Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965186AbWECMnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbWECMnV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 08:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbWECMnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 08:43:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61852 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965186AbWECMnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 08:43:20 -0400
Date: Wed, 3 May 2006 05:43:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: dvrabel@cantab.net, romieu@fr.zoreil.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net
Subject: Re: IP1000 gigabit nic driver
Message-Id: <20060503054300.b5e8b95f.akpm@osdl.org>
In-Reply-To: <1146475901.11271.3.camel@localhost>
References: <20060427142939.GA31473@fargo>
	<20060427185627.GA30871@electric-eye.fr.zoreil.com>
	<445144FF.4070703@cantab.net>
	<20060428075725.GA18957@fargo>
	<84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com>
	<20060428113755.GA7419@fargo>
	<Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI>
	<1146306567.1642.3.camel@localhost>
	<20060429122119.GA22160@fargo>
	<1146342905.11271.3.camel@localhost>
	<1146389171.11524.1.camel@localhost>
	<44554ADE.8030200@cantab.net>
	<1146475901.11271.3.camel@localhost>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 May 2006 12:31:40 +0300
Pekka Enberg <penberg@cs.helsinki.fi> wrote:

> [PATCH] IP1000 Gigabit Ethernet device driver
> 
> This is a cleaned up fork of the IP1000A device driver:
> 
>   http://www.icplus.com.tw/driver-pp-IP1000A.html

Please remember that to merge this we'll need a signed-off-by from the
original developers.  (That's not very gplish, but such is life).


