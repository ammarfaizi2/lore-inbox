Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316974AbSEWSKW>; Thu, 23 May 2002 14:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316975AbSEWSKV>; Thu, 23 May 2002 14:10:21 -0400
Received: from smtp.intrex.net ([209.42.192.250]:24586 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S316974AbSEWSKV>;
	Thu, 23 May 2002 14:10:21 -0400
Date: Thu, 23 May 2002 14:12:43 -0400
From: jlnance@intrex.net
To: roy@karlsbakk.net, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
Message-ID: <20020523141243.A1178@tricia.dyndns.org>
In-Reply-To: <200205231311.g4NDBO613726@mail.pronto.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 03:11:24PM +0200, Roy Sigurd Karlsbakk wrote:

> Starting up 30 downloads from a custom HTTP server (or Tux - or Apache - 
> doesn't matter), file size is 3-6GB, download speed = ~4.5Mbps. After some 
> time the kernel (a) goes bOOM (out of memory) if not having any swap, or (b) 
> goes gong swapping out anything it can.

Does this work if the client and the server are on the same machine?  It
would make reproducing this a lot easier if it only required 1 machine.

Thanks,

Jim
