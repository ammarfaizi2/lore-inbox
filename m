Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130750AbQLTCQR>; Tue, 19 Dec 2000 21:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130883AbQLTCQI>; Tue, 19 Dec 2000 21:16:08 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:47356 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130750AbQLTCPv>; Tue, 19 Dec 2000 21:15:51 -0500
Message-ID: <3A400F2A.E5CD52BA@haque.net>
Date: Tue, 19 Dec 2000 20:45:14 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: "David S. Miller" <davem@redhat.com>, tleete@mountain.net,
        laforge@gnumonks.org, rusty@linuxcare.com.au,
        netfilter-devel@us5.samba.org, linux-kernel@vger.kernel.org
Subject: Re: ip_defrag / ip_conntrack issues (was Re: [PATCH] Fix netfilter
In-Reply-To: <200012191454.RAA13529@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

how is this meaningless?

This just confirms what I and others have found in test12 wrt to the
netfilter issue.

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > able to lockup/OOPS his machine by logging into X as a user who had
> > his home directory over NFS.
> 
> I believe this report is to be ignored. It is fully meaningless.
> X has nothing to do with NFS, NFS is with X, and defragmenter is
> at least with one of them.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
