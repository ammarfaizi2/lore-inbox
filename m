Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316624AbSEVSCA>; Wed, 22 May 2002 14:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316625AbSEVSB7>; Wed, 22 May 2002 14:01:59 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33029 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316624AbSEVSB6>; Wed, 22 May 2002 14:01:58 -0400
Subject: Re: Have the 2.4 kernel memory management problems on large machines
To: joe@tmsusa.com (J Sloan)
Date: Wed, 22 May 2002 19:22:00 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <3CEBDB6C.5070005@tmsusa.com> from "J Sloan" at May 22, 2002 10:54:52 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AakK-0002UE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Huh? RH 7.3 kernel has the O(1) scheduler merged?
> 
> If the RH kernel is anything like the 2.4.19-pre8-ac5
> I'm currently running, that is  sweet indeed.

rpm -q --changelog |grep "O(1)"

