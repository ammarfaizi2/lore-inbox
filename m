Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbUL3Rxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbUL3Rxa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 12:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbUL3Rxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 12:53:30 -0500
Received: from adsl-161-130.38-151.net24.it ([151.38.130.161]:62095 "EHLO
	casa.e-den.it") by vger.kernel.org with ESMTP id S261684AbUL3Rx0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 12:53:26 -0500
Date: Thu, 30 Dec 2004 18:53:19 +0100
From: Sandro Dentella <sandro@e-den.it>
To: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
Message-ID: <20041230175319.GA2448@bluff>
Mail-Followup-To: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <m3is6k4oeu.fsf@reason.gnu-hamburg> <m38y7fn4ay.fsf@reason.gnu-hamburg> <v3rda2-hjn.ln1@news.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v3rda2-hjn.ln1@news.it.uc3m.es>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, well, don't put the journal on the raid partition. Put it
> elsewhere (anyway, journalling and raid do not mix, as write ordering
> is not - deliberately - preserved in raid, as far as I can tell).

???, do you mean it? which filesystem would you use for a 2TB RAID5 array? I
always used reiserfs for raid1/raid5 arrays...

sandro
*:-)


-- 
Sandro Dentella  *:-)
e-mail: sandro@e-den.it 
http://www.tksql.org                    TkSQL Home page - My GPL work
