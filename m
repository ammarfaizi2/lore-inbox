Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267855AbTAHMJ6>; Wed, 8 Jan 2003 07:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267856AbTAHMJ6>; Wed, 8 Jan 2003 07:09:58 -0500
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:27804
	"EHLO columba.www.eur.3com.com") by vger.kernel.org with ESMTP
	id <S267855AbTAHMJ5>; Wed, 8 Jan 2003 07:09:57 -0500
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: avery_fay@symantec.com
cc: linux-kernel@vger.kernel.org
Message-ID: <80256CA8.00438DDE.00@notesmta.eur.3com.com>
Date: Wed, 8 Jan 2003 12:17:39 +0000
Subject: Re: Gigabit/SMP performance problem
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Avery Fay wrote:
> can probably handle all of the interrupts. Really the issue I'm
> trying to solve is not routing performance, but rather the fact
> that SMP routing performance is worse while using twice
> the cpu time (2 cpu's at around 95% vs. 1 at around 95%).

Please forgive me if this is a silly suggestion, but are you sure this is a real
95% utilisation in the 2 CPU case. I think some versions of top show 0..200% for
the 2 CPU case, and therefore 95% utilisation is represents a  real CPU
utilisation of 47.5%

     Jon


