Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263346AbUKVTgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263346AbUKVTgK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbUKVTgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:36:09 -0500
Received: from gateway.penguincomputing.com ([64.243.132.186]:27865 "EHLO
	inside.penguincomputing.com") by vger.kernel.org with ESMTP
	id S263346AbUKVTds convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:33:48 -0500
X-Mda: Mail::Internet Mail::Sendmail Sendmail +mmhack 1.1 on Linux
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
User-Agent: Mutt/1.4.1i
Subject: Re: adm1026 driver port for kernel 2.6.10-rc2  [RE-REVISED DRIVER]
In-Reply-To: <20041120105740.1a238842.khali@linux-fr.org>
Content-Disposition: inline
Date: Mon, 22 Nov 2004 11:35:38 -0800
Message-Id: <20041122193538.GA4698@penguincomputing.com>
References: <20041102221745.GB18020@penguincomputing.com>
 <NN38qQl1.1099468908.1237810.khali@gcu.info>
 <20041103164354.GB20465@penguincomputing.com>
 <20041118185612.GA20728@penguincomputing.com>
 <20041120105740.1a238842.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: LM Sensors <sensors@Stimpy.netroedge.com>
Content-Transfer-Encoding: 8BIT
From: Justin Thiessen <jthiessen@penguincomputing.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 10:57:40AM +0100, Jean Delvare wrote:
> Hi Justin,
> 
> > Ok, let's try this (yet) again:
> 
> I'm sorry to insist be we really want this as a patch against
> 2.6.10-rc2. That's what Greg needs. As said earlier, the patch would
> include the new adm1026.c file (obviously) as well as the necessary
> changes to Kconfig and Makefile.

Ack.  Sorry for forgetting the Kconfig and Makefile changes. 

The driver itself is actually a patch against 2.6.10-rc2.

I'll post the driver once the issues Arjan raised have been resolved.

Justin Thiessen
---------------
jthiessen@penguincomputing.com

