Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131659AbRCOLGy>; Thu, 15 Mar 2001 06:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131665AbRCOLGo>; Thu, 15 Mar 2001 06:06:44 -0500
Received: from 13dyn6.delft.casema.net ([212.64.76.6]:1547 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S131659AbRCOLGY>; Thu, 15 Mar 2001 06:06:24 -0500
Message-Id: <200103151105.MAA24892@cave.bitwizard.nl>
Subject: Re: [PATCH] Improved version reporting
In-Reply-To: <UTC200103150952.KAA451302.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl"
 at "Mar 15, 2001 10:52:25 am"
To: Andries.Brouwer@cwi.nl
Date: Thu, 15 Mar 2001 12:05:09 +0100 (MET)
CC: acahalan@cs.uml.edu, viro@math.psu.edu, alan@lxorguk.ukuu.org.uk,
        linus@transmeta.com, linux-kernel@vger.kernel.org, rhw@memalpha.cx,
        seberino@spawar.navy.mil
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

>     > On Wed, 14 Mar 2001 Andries.Brouwer@cwi.nl wrote:
> 
>     >>> +o  Console Tools      #   0.3.3        # loadkeys -V
>     >>> +o  Mount              #   2.10e        # mount --version
>     >>
>     >> Concerning mount: (i) the version mentioned is too old,

> On the other hand, there are no important changes between
> mount-2.10d and 2.10e, so I see no justification for writing 2.10e.
> It is difficult to say what the "right" version is. There is a
> long series of minor improvements. Probably I would write 2.10r.

Guys, 

How about making a column that says: "recommended". 

So in this case we'd see 2.10r as recommended, but 2.10e as required.

An explanation could state that: 

  if you happen to have the version under "required", but a higher
  version is listed under "recommended", then that newer version is
  available, and but it is likely that one you have will work for
  you. There is no urgent reason to upgrade. But if you happen to be
  upgrading, you are advised upgrade to at least the version in the
  "recommended" column, as that has fixes over the one mentioned in the
  "required" column.

Best regards,

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
