Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265653AbRF1MbL>; Thu, 28 Jun 2001 08:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265655AbRF1MbB>; Thu, 28 Jun 2001 08:31:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47115 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265653AbRF1Maw>; Thu, 28 Jun 2001 08:30:52 -0400
Subject: Re: VM Requirement Document - v0.0
To: mike_phillips@urscorp.com
Date: Thu, 28 Jun 2001 13:30:44 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF95A43E53.39291B42-ON84256A79.003D421D@urscorp.com> from "mike_phillips@urscorp.com" at Jun 28, 2001 09:20:09 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FawW-0006qI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This would be extremely useful. My laptop has 256mb of ram, but every day 
> it runs the updatedb for locate. This fills the memory with the file 
> cache. Interactivity is then terrible, and swap is unnecessarily used. On 
> the laptop all this hard drive thrashing is bad news for battery life 

That isnt really down to labelling pages, what you are talking qbout is what
you get for free when page aging works right (eg 2.0.39) but don't get in
2.2 - and don't yet (although its coming) quite get right in 2.4.6pre.


