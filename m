Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130027AbRBKKVm>; Sun, 11 Feb 2001 05:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129992AbRBKKVc>; Sun, 11 Feb 2001 05:21:32 -0500
Received: from zeus.kernel.org ([209.10.41.242]:36068 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129748AbRBKKVU>;
	Sun, 11 Feb 2001 05:21:20 -0500
Message-ID: <3A865FC5.50576C00@namesys.com>
Date: Sun, 11 Feb 2001 12:47:49 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Adrian Phillips <a.phillips@dnmi.no>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
In-Reply-To: <E14RbJG-0001ds-00@the-village.bc.nu>
		<3A85AFC8.9070107@blue-labs.org> <3A864D6A.FDE7F6E4@namesys.com>
		<wvu261oa80.fsf@freeze.oslo.dnmi.no> <3A865462.E9CAED91@namesys.com> <wvpugpo8bl.fsf@freeze.oslo.dnmi.no>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Phillips wrote:
> 
> >>>>> "Hans" == Hans Reiser <reiser@namesys.com> writes:
> 
>     Hans> Adrian Phillips wrote:
>     >>  Does your test procedure include other systems, for example
>     >> reiserfs plus NFS ?
> 
>     Hans> Our NFS testing is simply inadequate, we need a copy of
>     Hans> LADDIS but haven't found the money for it yet.
> 
> Excuse my ignorance, but what is LADDIS ?
> 
> Sincerely,
> 
> Adrian Phillips
> 
> --
> Your mouse has moved.
> Windows NT must be restarted for the change to take effect.
> Reboot now?  [OK]

LADDIS is the industry standard benchmark for NFS.  It crashes for ReiserFS and
NFS.  We can't afford to buy it, as it is proprietary software.  Once Nikita has
finished testing his changes, we will ask someone to test it for us though.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
