Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbQKMOXy>; Mon, 13 Nov 2000 09:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129249AbQKMOXp>; Mon, 13 Nov 2000 09:23:45 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:5462
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129245AbQKMOXj>; Mon, 13 Nov 2000 09:23:39 -0500
Date: Mon, 13 Nov 2000 16:21:55 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: Oops on 2.2.17 [klogd bonus question]
Message-ID: <20001113162155.A18009@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm getting oopses on a linux 2.2.17 box when I try to do
tar cvIf <file> -X<file> /. Reproducably. This works fine 
for the std. RH 6.2 kernel (2.2.14-5). The resulting file 
is about 20MB.

I would submit the oops, but it is run through klogd and
I seem to remember people expressing dissatisfaction 
with klogd. So what do I do now to get a usable oops
to submit?

Regards,
  Rasmus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
