Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbUDHHhd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 03:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263145AbUDHHhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 03:37:33 -0400
Received: from [202.28.93.1] ([202.28.93.1]:4 "EHLO gear.kku.ac.th")
	by vger.kernel.org with ESMTP id S263037AbUDHHhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 03:37:32 -0400
Date: Thu, 8 Apr 2004 14:37:30 +0700
From: Kitt Tientanopajai <kitt@gear.kku.ac.th>
To: daniel.ritz@gmx.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5 yenta_socket irq 10: nobody cared!
Message-Id: <20040408143730.09b29b49.kitt@gear.kku.ac.th>
In-Reply-To: <200404072225.43358.daniel.ritz@gmx.ch>
References: <200404060227.58325.daniel.ritz@gmx.ch>
	<200404071741.47624.daniel.ritz@gmx.ch>
	<20040408022419.52ef7a29.kitt@gear.kku.ac.th>
	<200404072225.43358.daniel.ritz@gmx.ch>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> ok, try the attached one...at least it compiles..
> 
> rgds
> -daniel

Yes, the patch does work :) Now, I can insert card to the slot controlled by o2micro, no freeze :) My orinoco on TI controller works nicely too, no TX error anymore :)

Thank you very much for your help. 
kitt
