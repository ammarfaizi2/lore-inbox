Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318608AbSIISK4>; Mon, 9 Sep 2002 14:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318630AbSIISKz>; Mon, 9 Sep 2002 14:10:55 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:10431 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318608AbSIISKi>;
	Mon, 9 Sep 2002 14:10:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: root@chaos.analogic.com, Imran Badr <imran.badr@cavium.com>
Subject: Re: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 20:17:32 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "'David S. Miller'" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.3.95.1020909134937.18141A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020909134937.18141A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oT6L-0006qS-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 20:00, Richard B. Johnson wrote:
> For some reason, (claimed performance reasons) user-mode code
> has to be able to get data directly from hardware with no
> intervening copy operation. I think any claimed advantage goes
> away when you look at the overhead necessary for user-mode
> code to sleep before, and awaken after, the DMA operation but
> often marketing departments make those decisions.

Pfft.  Try turning off ide dma and see what happens.

-- 
Daniel
