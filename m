Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316754AbSEWOyr>; Thu, 23 May 2002 10:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316755AbSEWOyq>; Thu, 23 May 2002 10:54:46 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:41656 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S316754AbSEWOyq>; Thu, 23 May 2002 10:54:46 -0400
Date: Thu, 23 May 2002 07:54:05 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
Message-ID: <1486793366.1022140444@[10.10.2.3]>
In-Reply-To: <200205231311.g4NDBO613726@mail.pronto.tv>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> PROBLEM:
> ----------------------
> Starting up 30 downloads from a custom HTTP server (or Tux - or Apache - 
> doesn't matter), file size is 3-6GB, download speed = ~4.5Mbps. After some 
> time the kernel (a) goes bOOM (out of memory) if not having any swap, or (b) 
> goes gong swapping out anything it can.

How much RAM do you have, and what does /proc/meminfo
and /proc/slabinfo say just before the explosion point?

M.

