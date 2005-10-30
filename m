Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVJ3OiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVJ3OiW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 09:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVJ3OiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 09:38:22 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:45477
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932079AbVJ3OiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 09:38:22 -0500
Date: Sun, 30 Oct 2005 06:39:23 -0800 (PST)
Message-Id: <20051030.063923.14657004.davem@davemloft.net>
To: vonbrand@inf.utfsm.cl
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org, jbglaw@lug-owl.de
Subject: Re: SPARC64: Configuration offers keyboards that don't make sense 
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200510300326.j9U3QXeT027101@inti.inf.utfsm.cl>
References: <dtor_core@ameritech.net>
	<200510300326.j9U3QXeT027101@inti.inf.utfsm.cl>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst von Brand <vonbrand@inf.utfsm.cl>
Date: Sun, 30 Oct 2005 00:26:33 -0300

> > Sun keyboard can be autodetected AFAIK so you don't need to fiddle with
> > inputattach.
> 
> The setup works for the shipped Aurora kernel, but to compile that
> configuration would take a few days...

Do you try to load any keymaps at boot time?
Try to disable that.
