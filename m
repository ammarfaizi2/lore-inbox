Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVAYNPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVAYNPd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 08:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVAYNPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 08:15:33 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:54146 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261931AbVAYNP2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 08:15:28 -0500
Subject: Re: [PATCH] Modules: Allow sysfs module paramaters to be written
	to.
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: tj@home-tj.org, "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050125051244.GA656@kroah.com>
References: <200501132234.30762.rathamahata@ehouse.ru>
	 <20050114005948.GD4140@kroah.com> <1106463261.8118.13.camel@pegasus>
	 <20050125051244.GA656@kroah.com>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 14:15:16 +0100
Message-Id: <1106658916.8242.2.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Here's a patch that fixes this for me.  It's as if the function was
> never implemented at all for some reason.  Sorry for not catching this
> when tj's patches went in that changed all of this logic.
> 
> Let me know if this fixes the problem for you or not.

works fine for me. Please apply mainline as soon as possible.

Regards

Marcel


