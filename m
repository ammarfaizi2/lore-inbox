Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132307AbRBRBhr>; Sat, 17 Feb 2001 20:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132308AbRBRBhi>; Sat, 17 Feb 2001 20:37:38 -0500
Received: from jalon.able.es ([212.97.163.2]:42728 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132307AbRBRBhZ>;
	Sat, 17 Feb 2001 20:37:25 -0500
Date: Sun, 18 Feb 2001 02:37:14 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Keith Owens <kaos@ocs.com.au>, "J . A . Magallon" <jamagallon@able.es>,
        Hugh Dickins <hugh@veritas.com>,
        Paul Gortmaker <p_gortmaker@yahoo.com>,
        linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] a more efficient BUG() macro
Message-ID: <20010218023714.C951@werewolf.able.es>
In-Reply-To: <20010218013353.A1331@werewolf.able.es> <19480.982457293@ocs3.ocs-net> <3A8F266F.AFA01552@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A8F266F.AFA01552@uow.edu.au>; from andrewm@uow.edu.au on Sun, Feb 18, 2001 at 02:33:35 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.18 Andrew Morton wrote:
> 
> __BASE_FILE__ does this.  It expands to the thing which you
> typed on the `gcc' command line.
> 
..
> 3 at a.c
> 3 at a.c

I also thought that, but look at the line numbers...wrong and repeated.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac17 #1 SMP Sat Feb 17 01:47:56 CET 2001 i686

