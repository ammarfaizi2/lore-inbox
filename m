Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131175AbRBDN4h>; Sun, 4 Feb 2001 08:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131363AbRBDN4R>; Sun, 4 Feb 2001 08:56:17 -0500
Received: from [62.122.17.207] ([62.122.17.207]:51723 "EHLO penny")
	by vger.kernel.org with ESMTP id <S131175AbRBDN4M>;
	Sun, 4 Feb 2001 08:56:12 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 segfault when doing "ls /dev/"
In-Reply-To: <87u26avkfp.fsf@penny.ik5pvx.ampr.org>
	<3A7D5CFB.1C21ECD2@wanadoo.fr>
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 04 Feb 2001 15:00:43 +0100
In-Reply-To: <3A7D5CFB.1C21ECD2@wanadoo.fr>
Message-ID: <87lmrmv984.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:-> "Pierre" == Pierre Rousselet <pierre.rousselet@wanadoo.fr> writes:

    > Pierfrancesco Caci wrote:
    >> 48 ?        S      0:00 /sbin/devfsd /dev

    > on my box devfsd has pid 15, it comes just after the [kdaems]


    > and it works with 2.4.x

I can't see how this can affect performance/funtionality of
devfsd. Can you try to stop the daemon and restart it to see if
continues to work as before ?

Pf


-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.1 #1 Sat Feb 3 20:43:54 CET 2001 i686 unknown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
