Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbUKIRBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbUKIRBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 12:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbUKIRBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 12:01:40 -0500
Received: from thunk.org ([69.25.196.29]:21225 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261584AbUKIRBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 12:01:35 -0500
Date: Tue, 9 Nov 2004 11:58:18 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Adrian Bunk <bunk@stusta.de>
Cc: support@comtrol.com, linux-kernel@vger.kernel.org
Subject: Re: Licencing of drivers/char/rocket.c ?
Message-ID: <20041109165818.GB5169@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Adrian Bunk <bunk@stusta.de>, support@comtrol.com,
	linux-kernel@vger.kernel.org
References: <20041106235236.GX1295@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106235236.GX1295@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 12:52:36AM +0100, Adrian Bunk wrote:
> Hi,
> 
> could you clarify the licensing of drivers/char/rocket.c ?
> 

I developed the Rocketport device driver under contract of Comtrol,
with the understanding that the resulting device driver would be
released under the GPL.  So I believe the correct way of resolving the
conflicting copyright statements is to delete the following lines.

It would be good to get positive confirmation from Comtrol as well
that this is their understanding as well.  Otherwise, we will need to
remove the Rocketport driver from the mainline Linux kernel.

						- Ted

> /***********************************************************************
>                 Copyright 1994 Comtrol Corporation.
>                         All Rights Reserved.
> 
> The following source code is subject to Comtrol Corporation's
> Developer's License Agreement.
> 
> This source code is protected by United States copyright law and 
> international copyright treaties.
> 
> This source code may only be used to develop software products that
> will operate with Comtrol brand hardware.
> 
> You may not reproduce nor distribute this source code in its original
> form but must produce a derivative work which includes portions of
> this source code only.
> 
> The portions of this source code which you use in your derivative
> work must bear Comtrol's copyright notice:
> 
>                 Copyright 1994 Comtrol Corporation.
> 
> ***********************************************************************/


