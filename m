Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129184AbRBZWat>; Mon, 26 Feb 2001 17:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129185AbRBZWaj>; Mon, 26 Feb 2001 17:30:39 -0500
Received: from jalon.able.es ([212.97.163.2]:12177 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129184AbRBZWa2>;
	Mon, 26 Feb 2001 17:30:28 -0500
Date: Mon, 26 Feb 2001 23:30:13 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: David <dllorens@lsi.uji.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Posible bug in gcc
Message-ID: <20010226233013.A2995@werewolf.able.es>
In-Reply-To: <3A9A8489.224CF54C@inf.uji.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A9A8489.224CF54C@inf.uji.es>; from dllorens@lsi.uji.es on Mon, Feb 26, 2001 at 17:30:01 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.26 David wrote:
> I hope you will find this information usefull.
> 
> I am not in the linux-kernel list so, if posible, I would like to be
> personally CC'ed the answers/comments sent to the list in response to
> this posting.
> 
> I think I heve found a bug in gcc. I have tried both egcs 1.1.2 (gcc
> 2.91.66) and gcc 2.95.2 versions.
> 

gcc2.95.2 is sane in irix6.2, irix6.5 and solaris7sparc.

The optimizer is not in the common front-end ?

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac4 #2 SMP Mon Feb 26 00:21:23 CET 2001 i686

