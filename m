Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314458AbSEVVp5>; Wed, 22 May 2002 17:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314558AbSEVVp4>; Wed, 22 May 2002 17:45:56 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48136 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314458AbSEVVpz>; Wed, 22 May 2002 17:45:55 -0400
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
To: Martin.Bligh@us.ibm.com (Martin J. Bligh)
Date: Wed, 22 May 2002 23:05:17 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        wli@holomorphy.com (William Lee Irwin III),
        znmeb@aracnet.com (M. Edward Borasky), linux-kernel@vger.kernel.org,
        andrea@suse.de, riel@surriel.com, torvalds@transmeta.com,
        akpm@zip.com.au
In-Reply-To: <366680000.1022091897@flay> from "Martin J. Bligh" at May 22, 2002 11:24:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AeEP-0002wE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If my spies are correct, 7.3AS kernel is still based off the old 2.4.9 VM, with
> no rmap at present ... correct? I presume 7.3 is 2.4.18 or so VM with rmap?

<Red Hat Marketing>There is no such product as 7.3AS</Red Hat Marketing> ;) 

The AS 2.1 kernel is 2.4.9 based for enterprise stability with the pre
Linus being hit by cosmic rays VM fixed and tuned for enterprise workloads.

7.3 is the rmap VM

Alan
