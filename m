Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVJJJsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVJJJsH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 05:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVJJJsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 05:48:07 -0400
Received: from scipost.dolphinics.no ([193.71.152.3]:26785 "EHLO
	scipost.dolphinics.no") by vger.kernel.org with ESMTP
	id S1750721AbVJJJsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 05:48:04 -0400
Message-ID: <434A38D0.9040103@dolphinics.no>
Date: Mon, 10 Oct 2005 11:48:00 +0200
From: Simen Thoresen <simentt@dolphinics.no>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Devesh Sharma <devesh28@gmail.com>
CC: linux-kernel@vger.kernel.org, rdunlap@xenotime.net
Subject: Re: Issues in Booting kernel 2.6.13
References: <309a667c0510052216n784e229ei69b3a3a2a9e93f4b@mail.gmail.com>	 <20051006190806.388289ff.rdunlap@xenotime.net>	 <43481D0F.9020407@dolphinics.no>	 <20051008123131.41d85d45.rdunlap@xenotime.net>	 <434A23A2.1020407@dolphinics.no>	 <309a667c0510100215wcf311bcr3cc0555cc4557d39@mail.gmail.com> <309a667c0510100228s5c9bac7cwaf74548520bba808@mail.gmail.com>
In-Reply-To: <309a667c0510100228s5c9bac7cwaf74548520bba808@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Devesh,

I still have problems, and I see both mptbase and mptscsih loading, so 
I've assumed that mkinitrd is not happy with the new kernel.

Could you please mail me your .config directly so I can have a look at it?

-S

Devesh Sharma wrote:
> Hi,
> Randy, Simen and list
> I am sorry , I could not reply ur post on 6th oct as I  have noticed
> ur reply today. But I have got the solution for this.
> 
> During make menuconfig I forgot to include MPT FUSION device support
> in my erlier compilation. But Now this is working fine
> 
> I am sorry If this has created any confusion among the list.
> Or If its really an issue then let me know also.
> 
> Thanks
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Simen Thoresen, Wulfkit Support, Dolphin ICS
http://www.tysland.com/~simentt/cluster
