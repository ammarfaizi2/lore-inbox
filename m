Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWHIPrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWHIPrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 11:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWHIPrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 11:47:04 -0400
Received: from mx2.mail.ru ([194.67.23.122]:26975 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1750992AbWHIPrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 11:47:02 -0400
Date: Wed, 9 Aug 2006 18:46:58 +0300
From: Sergei Steshenko <steshenko_sergei@list.ru>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, alsa-user@lists.sourceforge.net
Subject: Re: [Alsa-user] another in kernel alsa update that breaks backward
 compatibilty?
Message-ID: <20060809184658.2bdfb169@comp.home.net>
In-Reply-To: <200608091140.02777.gene.heskett@verizon.net>
References: <200608091140.02777.gene.heskett@verizon.net>
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.3; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2006 11:40:02 -0400
Gene Heskett <gene.heskett@verizon.net> wrote:

> Greetings;
> 
> The old fart is back again. :)
> 
> I've just done a divide and conquer on kernel versions, and have found that 
> while I DO have a kde audio signon for kernels 2.6.18-rc1-rc3-rc4, I do 
> not have any other functioning audio, including the kde sound effects I 
> normally get.  xmms and tvtime are mute, as are the firefox plugins to 
> play videos from the network. 2.6.17.8 and below works great yet.
> 
> So whats the fix?
> 


Demand stable ABI.

-- 
Visit my http://appsfromscratch.berlios.de/ open source project.
