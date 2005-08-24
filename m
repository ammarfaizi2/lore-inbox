Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVHXKMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVHXKMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 06:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVHXKMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 06:12:15 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:56986 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1750715AbVHXKMO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 06:12:14 -0400
Message-ID: <430C47F6.8050805@namesys.com>
Date: Wed, 24 Aug 2005 14:12:06 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: raja <vnagaraju@effigent.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: delay
References: <430C1772.4030308@effigent.net>
In-Reply-To: <430C1772.4030308@effigent.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

raja wrote:
> Hi,
>    Would you please tell me how to write a function that generates a
> delay of Less than a sec.(ie for 1 milli se or one microsec etc).
> 

Maybe you could use: linux/kernel/timer.c:schedule_timeout()

> Thankingyou,
> Raja
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

