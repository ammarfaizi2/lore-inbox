Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266531AbUHCOr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUHCOr4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 10:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUHCOr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 10:47:56 -0400
Received: from magic.adaptec.com ([216.52.22.17]:18411 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S266580AbUHCOrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 10:47:41 -0400
Message-ID: <410FA577.4040602@adaptec.com>
Date: Tue, 03 Aug 2004 10:47:19 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: "Justin T. Gibbs" <gibbs@scsiguy.com>, Adrian Bunk <bunk@fs.tum.de>,
       James.Bottomley@HansenPartnership.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let AIC7{9,X}XX_BUILD_FIRMWARE depend on !PREVENT_FIRMWARE_BUILD
References: <20040801185543.GB2746@fs.tum.de> <20040801191118.GA7402@mars.ravnborg.org>
In-Reply-To: <20040801191118.GA7402@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Aug 2004 14:47:27.0249 (UTC) FILETIME=[CB97A810:01C47968]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

You can forward it to Linus and I'll also integrate it
to the latest version of the drivers, yet to be integrated
to the mainline kernel.

Thanks!

Sam Ravnborg wrote:
> On Sun, Aug 01, 2004 at 08:55:44PM +0200, Adrian Bunk wrote:
>  >
>  > The patch below lets AIC7{9,X}XX_BUILD_FIRMWARE depend on
>  > !PREVENT_FIRMWARE_BUILD.
> 
> Justin, I agree with this change. Please let me know if I shall forward
> the patch to Linus, or you will take care.
> 
>         Sam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Luben


