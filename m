Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263338AbUEKS4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUEKS4K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 14:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUEKSzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 14:55:54 -0400
Received: from 10.69-93-172.reverse.theplanet.com ([69.93.172.10]:57059 "EHLO
	gsf.ironcreek.net") by vger.kernel.org with ESMTP id S263338AbUEKSzr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 14:55:47 -0400
From: Andre Eisenbach <andre@eisenbach.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon Mobile XP CPU speed problem
Date: Tue, 11 May 2004 11:54:27 -0700
User-Agent: KMail/1.6.2
References: <200404091723.55628.andre@ironcreek.net>
In-Reply-To: <200404091723.55628.andre@ironcreek.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405111154.27631.andre@eisenbach.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here some additional information I picked up on the HP support forums:

> However HP seems to be adding a further amount of throttling when under
> battery power using 'Stop Clock' techniques. When minimal levels of power 
> management are applied the processor is only running 1/3 of the time 
> reducing to 1/6 of the time when using more stringent power settings (eg Max 
> Battery)    

Does that help in any way fixing this problem?
Short of a BIOS update, is there a way to work around this?

Please also see this recent LKLM email for reference:
http://lkml.org/lkml/2004/5/9/100

Thanks,
   André
