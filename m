Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSEVOtE>; Wed, 22 May 2002 10:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSEVOrv>; Wed, 22 May 2002 10:47:51 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58385 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315558AbSEVOqW>; Wed, 22 May 2002 10:46:22 -0400
Subject: Re: [PATCH] 2.5.17 /dev/ports
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 22 May 2002 16:05:52 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rmk@arm.linux.org.uk (Russell King),
        davem@redhat.com (David S. Miller), paulus@samba.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <3CEB8FEC.5000702@evision-ventures.com> from "Martin Dalecki" at May 22, 2002 02:32:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AXgW-0001y8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The /dev/port interface is used by various apps and its a traditional
> > x86 in paticular unix thing. For platforms like ARM its poorly implemented
> 
> Erm... unix thing? I see it only in Linux...
> BTW. Just recently someone has found out that it is indeed
> *poorly* implemented.

Well you should learn to use grep, google and a library then. The /dev/port
interface is in a whole variety of older Unixen for x86, and also in systems
like Minix.

