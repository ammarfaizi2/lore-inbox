Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbUKJDer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbUKJDer (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 22:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbUKJDer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 22:34:47 -0500
Received: from ozlabs.org ([203.10.76.45]:19944 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261839AbUKJDeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 22:34:46 -0500
Subject: Re: [PATCH] WOL for sis900
From: Rusty Russell <rusty@rustcorp.com.au>
To: Malte =?ISO-8859-1?Q?Schr=F6der?= <MalteSch@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4183B6B0.7010906@gmx.de>
References: <4183B6B0.7010906@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 10 Nov 2004 13:58:52 +1100
Message-Id: <1100055532.25963.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-30 at 17:43 +0200, Malte Schröder wrote:
> Hello,
> I have applied the patch from http://lkml.org/lkml/2003/7/16/88 manually 
> to 2.6.7 (also works on 2.6.{8,9}) and have been using it since then.
> Attached is a diff against 2.6.9.

Want to change the MODULE_PARM to new-style module_param() calls, too?

Thanks,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

