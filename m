Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266272AbUA2AoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 19:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266275AbUA2AoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 19:44:07 -0500
Received: from smtp08.auna.com ([62.81.186.18]:445 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S266272AbUA2AoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 19:44:05 -0500
Date: Thu, 29 Jan 2004 01:44:02 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [BK PATCH] i2c driver fixes for 2.6.2-rc2
Message-ID: <20040129004402.GC5830@werewolf.able.es>
References: <20040127233242.GA28891@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040127233242.GA28891@kroah.com> (from greg@kroah.com on Wed, Jan 28, 2004 at 00:32:42 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.01.28, Greg KH wrote:
> Hi,
> 
> Here are some i2c driver fixes for 2.6.2-rc2.  It's all a bit of small
> bugfixes and documentation updates.
> 

After upgrading to sensors 2.8.3 (first I compiled it, then installed the
Makdrake package when appeared), my temperatures are still mutiplied by 10.
I use 2.6.2-rc2-mm1.

Any ideas ?

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.2-rc2-jam1 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
