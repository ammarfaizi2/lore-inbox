Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129641AbRBFTNE>; Tue, 6 Feb 2001 14:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbRBFTMz>; Tue, 6 Feb 2001 14:12:55 -0500
Received: from jalon.able.es ([212.97.163.2]:22173 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129641AbRBFTMn>;
	Tue, 6 Feb 2001 14:12:43 -0500
Date: Tue, 6 Feb 2001 20:12:32 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Christoph Rohland <cr@sap.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /dev/shm mount visible
Message-ID: <20010206201232.C4892@werewolf.able.es>
In-Reply-To: <20010206160110.A4163@werewolf.able.es> <m3ofwfaakt.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <m3ofwfaakt.fsf@linux.local>; from cr@sap.com on Tue, Feb 06, 2001 at 20:13:54 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.06 Christoph Rohland wrote:
> On Tue, 6 Feb 2001, jamagallon@able.es wrote:
> > Just a little question. In previous kernels and shm patches the
> > /dev/shm filesytem was invisible under a 'mount' query (just managed
> > like procfs or devpts). 
> 
> mount does always show all mounted fses. I asume you mean df.
> 

Right, was checking both things...

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac3 #1 SMP Tue Feb 6 01:06:05 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
