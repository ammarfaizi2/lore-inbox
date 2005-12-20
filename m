Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVLTXQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVLTXQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 18:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVLTXQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 18:16:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23494 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932201AbVLTXQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 18:16:55 -0500
Date: Tue, 20 Dec 2005 15:16:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizononline.net
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: Sensors errors with 15-rc6, 15-rc5 was normal
Message-Id: <20051220151616.c8bdc00c.akpm@osdl.org>
In-Reply-To: <200512201505.43199.gene.heskett@verizon.net>
References: <200512201505.43199.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
> To whomever is in charge of the sensors code in the kernel:
> 
> I just noted that the temperatures being reported by gkrellm, using its 
> internal sensors stuff, are not correct by over 100F too low when -rc6 
> is running.  -rc5 seems to give good readings consistent with what 
> I've been observing for the last year, a slowly rising cpu reading due 
> to the zallman flower becoming dust packed, to the point of about 150F 
> for a normal reading.
> 
> Today, after rebooting to -rc6, I'm seeing cpu temps ranging between 
> 39.2 and 41.7 degress F. As the room is probably around 74F, thats a 
> bit of a dubious reading.
> 
> Whom do I contact about this? 
> 

Jean.
