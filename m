Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317193AbSEXPXt>; Fri, 24 May 2002 11:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSEXPXs>; Fri, 24 May 2002 11:23:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38924 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317193AbSEXPXp>; Fri, 24 May 2002 11:23:45 -0400
Subject: Re: 2.4.19-pre8 ide bugs
To: nick@octet.spb.ru
Date: Fri, 24 May 2002 16:35:53 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <004101c20334$361b0b80$baefb0d4@nick> from "Nick Evgeniev" at May 24, 2002 07:03:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BH6f-0006da-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've got the following problem with 2.4.19-pre8 &
> ide-2.4.19-p7.all.convert.10.patch (w/o patch & I've more fatal problems
> with sb & filesystem corruptions) kernel reports "kernel: bug: kernel timer
> added twice at c01a7356." & panics.
> 
> Is it a known issue? What is the solution??? I remember that with 2.4.7 I

Does this happen with the up to date IDE code (2.4.19-pre8-ac5 ?). Also
what drives do you have ?
