Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129481AbQKMMyt>; Mon, 13 Nov 2000 07:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129050AbQKMMyj>; Mon, 13 Nov 2000 07:54:39 -0500
Received: from astrid2.nic.fr ([192.134.4.2]:43022 "EHLO astrid2.nic.fr")
	by vger.kernel.org with ESMTP id <S129481AbQKMMya>;
	Mon, 13 Nov 2000 07:54:30 -0500
Date: Mon, 13 Nov 2000 13:54:45 +0000
From: Francois romieu <romieu@ensta.fr>
To: aprasad@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: reliability of linux-vm subsystem
Message-ID: <20001113135445.A12459@nic.fr>
Reply-To: Francois romieu <romieu@ensta.fr>
In-Reply-To: <CA256996.004352F8.00@d73mta05.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <CA256996.004352F8.00@d73mta05.au.ibm.com>; from aprasad@in.ibm.com on Mon, Nov 13, 2000 at 05:29:48PM +0530
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Mon, Nov 13, 2000 at 05:29:48PM +0530, aprasad@in.ibm.com wrote :
[...]
> When i run following code many times.
> System becomes useless till all of the instance of this programming are
> killed by vmm.
[malloc bomb]

Check some archives of the linux-kernel list for "overcommit".

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
