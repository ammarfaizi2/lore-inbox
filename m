Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbVKWKtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbVKWKtb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 05:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbVKWKtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 05:49:31 -0500
Received: from mailgate.tebibyte.org ([83.104.187.130]:20740 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S1030393AbVKWKta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 05:49:30 -0500
Message-ID: <4384490D.7020409@tebibyte.org>
Date: Wed, 23 Nov 2005 10:48:45 +0000
From: Chris Ross <lak1646@tebibyte.org>
Organization: At home (Guildford, UK)
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Chris Ross <lak1646@tebibyte.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Kernel panic reading bad disk sector
References: <4381DA23.10201@tebibyte.org> <4382B815.5000701@snapgear.com>	<43836758.6050001@tebibyte.org> <4383C205.7020608@snapgear.com>	<43843594.9050009@tebibyte.org>	<20051123095640.GA5022@flint.arm.linux.org.uk> <438443E8.5040602@tebibyte.org>
In-Reply-To: <438443E8.5040602@tebibyte.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Ross escreveu:
> For those just tuning in this is about an ARM system with a Promise 
> 20275 IDE controller which suffers a kernel panic when attempting to 
> read from a bad sector on the disk.

And the vital piece of information I missed - on kernels 2.4.31-uc0 and 
2.4.27-uc1 at least. At this stage it's believed to be from upstream - 
i.e. it's probably also in vanilla 2.4.32 although I haven't tested that.

Regards,
Chris R.
