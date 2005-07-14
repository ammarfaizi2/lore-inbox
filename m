Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263054AbVGNSIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263054AbVGNSIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbVGNSIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:08:38 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:8169 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S263069AbVGNSIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:08:32 -0400
Date: Thu, 14 Jul 2005 20:08:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: kernel <kernel@crazytrain.com>
cc: Konstantin Kudin <konstantin_kudin@yahoo.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, lkml@dervishd.net,
       linux-kernel@vger.kernel.org
Subject: Re: fdisk: What do plus signs after "Blocks" mean?
In-Reply-To: <1121349002.3718.11.camel@crazytrain>
Message-ID: <Pine.LNX.4.61.0507142007500.21087@yvahk01.tjqt.qr>
References: <20050712204822.84567.qmail@web52001.mail.yahoo.com> 
 <Pine.LNX.4.61.0507131222300.14635@yvahk01.tjqt.qr> <1121349002.3718.11.camel@crazytrain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I always thought;
>
>First 446 bytes are boot code and all

Right, of course. Otherwise it won't sum up to 512 bytes.



Jan Engelhardt
-- 
