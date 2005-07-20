Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVGTJs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVGTJs0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 05:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVGTJs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 05:48:26 -0400
Received: from mail.portrix.net ([212.202.157.208]:10665 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261439AbVGTJsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 05:48:25 -0400
Message-ID: <42DE1DDE.90503@ppp0.net>
Date: Wed, 20 Jul 2005 11:48:14 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: snogglethorpe@gmail.com, miles@gnu.org
CC: linux-kernel@vger.kernel.org
Subject: Re: defconfig for v850, please
References: <42DE17DC.7050506@ppp0.net> <fc339e4a05072002355e4062d6@mail.gmail.com>
In-Reply-To: <fc339e4a05072002355e4062d6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader wrote:
> 2005/7/20, Jan Dittmer <jdittmer@ppp0.net>:
> 
>>while you're at it patching v850 here and there, could you please
>>also provide a resonable defconfig for v850, so that
> 
> 
> I must admit it's because I've never quite understood how the
> defconfig stuff works... I'll look into it I guess...

I think you just need to provide a file called 'defconfig' in
arch/v850/

Thanks,

-- 
Jan
