Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264080AbRFXLBB>; Sun, 24 Jun 2001 07:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264108AbRFXLAv>; Sun, 24 Jun 2001 07:00:51 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:8446 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S264080AbRFXLAo>; Sun, 24 Jun 2001 07:00:44 -0400
Message-ID: <3B35C870.6F5331F1@uow.edu.au>
Date: Sun, 24 Jun 2001 21:01:04 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ghofmann@pair.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 3C905B module/builtin lockup on 2.4.6-pre3-5
In-Reply-To: <3B34AC94.26847.1733F0@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Glenn C. Hofmann" wrote:
> 
> After attempting different configurations for the past 3 hours, I am at a loss.

THis is unusual.  Are you really sure that everything has 
compiled correctly?  Have you done a `make clean' before
building the kernel?

It so, it's important to identify when things were last working
OK.  Did 2.4.5 work OK?  2.4.4?
