Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313217AbSEERcG>; Sun, 5 May 2002 13:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313238AbSEERcF>; Sun, 5 May 2002 13:32:05 -0400
Received: from pD950B1E6.dip0.t-ipconnect.de ([217.80.177.230]:22364 "EHLO
	mordor.svara") by vger.kernel.org with ESMTP id <S313217AbSEERcE>;
	Sun, 5 May 2002 13:32:04 -0400
Date: Sun, 5 May 2002 21:34:20 +0200
From: Fabian Svara <svara@gmx.net>
To: Christian Borntr <linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:82
Message-Id: <20020505213420.30257ffd.svara@gmx.net>
In-Reply-To: <200205051853.38557.linux-kernel@borntraeger.net>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 May 2002 18:53:38 +0200
Christian Borntr  <linux-kernel@borntraeger.net> wrote:

> Fabian Svara wrote:
> > EIP:	0010:[<c0125183>]    Tainted: P
> 
> You have the Binary-NVIDIA Driver loaded, haven't you?
> If yes, please report this bug to Nvidia, since nobody here can help
> you because the main part of the driver is closed source and nobody
> knows, what the driver is doing with the memory.
> 
> Christian

Yes, indeed. I will send the report to nvidia. I thought it wasn't
nvidia-realted as there was no mention of it in the ksymoops-resolved
report... But in fact, all problems involving there kernel I've had here
were somehow related to those drivers.

-Fabian Svara
