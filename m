Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136067AbRA1Lg3>; Sun, 28 Jan 2001 06:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136188AbRA1LgT>; Sun, 28 Jan 2001 06:36:19 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:4648 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S136067AbRA1LgD>; Sun, 28 Jan 2001 06:36:03 -0500
Message-ID: <3A740416.55E93274@linux.com>
Date: Sun, 28 Jan 2001 11:35:50 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc update/fixes for sysrq.txt
In-Reply-To: <20010128051118.A7975@foozle.turbogeek.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeremy M. Dolan" wrote:

> +Note that previous versions disabled sysrq by default, and you were required
> +to specifically enable it at run-time. That is not the case any longer.

AFAIK, this hasn't ever been true.  I have never had to specifically enable it at
run time.  There are certain distributions which disabled it by default but this is
distribution specific, not by way of the kernel.

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
