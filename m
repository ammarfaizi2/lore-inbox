Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSJ0IKS>; Sun, 27 Oct 2002 03:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262304AbSJ0IKS>; Sun, 27 Oct 2002 03:10:18 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:22455 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262303AbSJ0IKR>;
	Sun, 27 Oct 2002 03:10:17 -0500
Message-ID: <3DBBAEF7.7060507@colorfullife.com>
Date: Sun, 27 Oct 2002 10:16:39 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: KORN Andras <korn-linuxkernel@chardonnay.math.bme.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4 very slow memory access on abit kd7raid (kt400); ten times
 slower than on kg7raid
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It could be a bug in the memory detection. I had a similar problem with 
one PC-chips board.

Could you check if
- an explicit "mem=63m" line helps?
- disabling all power management in the bios help?

--
    Manfred

