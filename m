Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317954AbSFSRqr>; Wed, 19 Jun 2002 13:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317956AbSFSRqr>; Wed, 19 Jun 2002 13:46:47 -0400
Received: from [213.23.20.58] ([213.23.20.58]:49046 "EHLO starship")
	by vger.kernel.org with ESMTP id <S317954AbSFSRqp>;
	Wed, 19 Jun 2002 13:46:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (2/2) reverse mappings for current 2.5.23 VM
Date: Wed, 19 Jun 2002 19:46:26 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-mm@kvack.org
References: <Pine.LNX.4.44.0206190231520.3637-100000@loke.as.arizona.edu>
In-Reply-To: <Pine.LNX.4.44.0206190231520.3637-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17KjXH-0000vN-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 June 2002 13:21, Craig Kulesa wrote:
> 2.5.22 vanilla:
      ^^--- is this a typo?

> Total kernel swapouts during test = 29068 kB
> Total kernel swapins during test  = 16480 kB
> Elapsed time for test: 141 seconds
> 
> 2.5.23-rmap (this patch -- "rmap-minimal"):           
> Total kernel swapouts during test = 24068 kB
> Total kernel swapins during test  =  6480 kB
> Elapsed time for test: 133 seconds
> 
> 2.5.23-rmap13b (Rik's "rmap-13b complete") :
> Total kernel swapouts during test = 40696 kB
> Total kernel swapins during test  =   380 kB
> Elapsed time for test: 133 seconds

-- 
Daniel
