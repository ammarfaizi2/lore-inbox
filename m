Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136120AbRAZQdC>; Fri, 26 Jan 2001 11:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136114AbRAZQcx>; Fri, 26 Jan 2001 11:32:53 -0500
Received: from 13dyn226.delft.casema.net ([212.64.76.226]:61447 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S136039AbRAZQcj>; Fri, 26 Jan 2001 11:32:39 -0500
Message-Id: <200101261632.RAA19438@cave.bitwizard.nl>
Subject: Re: Odd network trace...
In-Reply-To: <14961.42315.441894.892277@pizda.ninka.net> from "David S. Miller"
 at "Jan 26, 2001 08:26:51 am"
To: "David S. Miller" <davem@redhat.com>
Date: Fri, 26 Jan 2001 17:32:32 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> 
> Rogier Wolff writes:
>  > Am I missing something?
>  ...
>  > 17:05:59.961324 server.http > client.1880: . 1:1(0) ack 287912 win 0 <nop,nop,timestamp 2800084 363441235> (DF)
> 
> server advertises zero window, no data may be sent.

Yep, I WAS missing someting. Thanks.

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
