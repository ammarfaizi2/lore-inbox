Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310632AbSCPUpb>; Sat, 16 Mar 2002 15:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310625AbSCPUpW>; Sat, 16 Mar 2002 15:45:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36362 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310622AbSCPUpM>; Sat, 16 Mar 2002 15:45:12 -0500
Subject: Re: 2.4.19-pre2 Cyrix III SEGFAULT (Cyrix II redux?)
To: davej@suse.de (Dave Jones)
Date: Sat, 16 Mar 2002 21:01:06 +0000 (GMT)
Cc: egberts@yahoo.com (S W), linux-kernel@vger.kernel.org
In-Reply-To: <20020316204228.B15296@suse.de> from "Dave Jones" at Mar 16, 2002 08:42:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mLIY-00079l-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > But I recalled Linux 2.2 having a bug fix for broken
>  > L2 cache in Cyrix II.
>  
>  The cache itself isn't broken. Reporting of the size of it is.

He's talking about a different bug. Some early 6x86 processors had weird
problems with cache behaviour that would sometimes break stuff.
