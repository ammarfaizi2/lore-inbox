Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317917AbSGKVzu>; Thu, 11 Jul 2002 17:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317918AbSGKVzt>; Thu, 11 Jul 2002 17:55:49 -0400
Received: from jalon.able.es ([212.97.163.2]:22216 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S317917AbSGKVzt>;
	Thu, 11 Jul 2002 17:55:49 -0400
Date: Thu, 11 Jul 2002 23:57:39 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fsync fixes for 2.4
Message-ID: <20020711215739.GA6641@werewolf.able.es>
References: <20020710202036.GA1342@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020710202036.GA1342@dualathlon.random>; from andrea@suse.de on Wed, Jul 10, 2002 at 22:20:36 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.10 Andrea Arcangeli wrote:
>At polyserve they found a severe problem with fsync in 2.4.
[patch trimmed]

Does this apply also to  -aa, or other changes make it unnecessary ?

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc1-jam2, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.7mdk)
