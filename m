Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129691AbRBURbM>; Wed, 21 Feb 2001 12:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129892AbRBURbC>; Wed, 21 Feb 2001 12:31:02 -0500
Received: from [213.155.192.193] ([213.155.192.193]:2052 "HELO motoko")
	by vger.kernel.org with SMTP id <S129807AbRBURav>;
	Wed, 21 Feb 2001 12:30:51 -0500
Date: Wed, 21 Feb 2001 18:38:02 +0100
From: Frank Contrepois <sokak@telvia.it>
To: linux-kernel@vger.kernel.org
Subject: CWND always 2
Message-ID: <20010221183802.A174@motoko.2y.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-PGP-Id: 35070F6A Available at keyserver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to figure aout the different values taken by snd_cwnd
and after a little of work i find out that the number 2 is 
the maximum reached.. even when passing a 100MB file on a 
LAN

can you explain that to me???

I'm working on a 2.4.1 kernel
i386

i've tried out with proc and printk....

please answer me at sokak@tin.it

thanx hopping not to bother anyone
-- 
Pazzooo
