Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132659AbRC2Dyz>; Wed, 28 Mar 2001 22:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132662AbRC2Dyp>; Wed, 28 Mar 2001 22:54:45 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22029 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132659AbRC2Dye>; Wed, 28 Mar 2001 22:54:34 -0500
Subject: Re: Larger dev_t
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Thu, 29 Mar 2001 04:53:30 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
   torvalds@transmeta.com (Linus Torvalds), hpa@transmeta.com (H. Peter Anvin),
   Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
In-Reply-To: <3AC2587F.8149C3E9@evision-ventures.com> from "Martin Dalecki" at Mar 28, 2001 11:32:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14iTV6-00072X-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why do you worry about installers? New distro - new kernel - new
> installer

Because the same code tends to be shared with post install configuration
tools too. 


