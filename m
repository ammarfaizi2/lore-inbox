Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315734AbSEVPMX>; Wed, 22 May 2002 11:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315850AbSEVPMW>; Wed, 22 May 2002 11:12:22 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19474 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315734AbSEVPLx>; Wed, 22 May 2002 11:11:53 -0400
Subject: Re: [PATCH] 2.5.17 /dev/ports
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 22 May 2002 16:31:52 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davem@redhat.com (David S. Miller),
        paulus@samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <3CEBA2D4.4080804@evision-ventures.com> from "Martin Dalecki" at May 22, 2002 03:53:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AY5h-00022j-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /proc/cpuinfo for one could be replaced by dropping syslog
> messages at a fixed file in /etc/ during boot - it's static after
> all!.

Wrong on that one too

