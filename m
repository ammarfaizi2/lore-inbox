Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316339AbSEVRbl>; Wed, 22 May 2002 13:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSEVRbj>; Wed, 22 May 2002 13:31:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58116 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316339AbSEVRbi>; Wed, 22 May 2002 13:31:38 -0400
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
To: Martin.Bligh@us.ibm.com
Date: Wed, 22 May 2002 18:50:53 +0100 (BST)
Cc: wli@holomorphy.com (William Lee Irwin III),
        znmeb@aracnet.com (M. Edward Borasky), linux-kernel@vger.kernel.org,
        andrea@suse.de, riel@surriel.com, torvalds@transmeta.com,
        akpm@zip.com.au
In-Reply-To: <1403412981.1022057064@[10.10.2.3]> from "Martin J. Bligh" at May 22, 2002 08:44:25 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AaGD-0002OH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wouldn't bother using RedHat's kernel for this at the moment, 
> Andrea's tree is where the development work for this area has all
> been happening recently. He's working on integrating O(1) sched
> right now, which will get rid of the biggest issue I have with -aa

Still ? Its been in the Red Hat 7.3 tree since we released it. Its also
in the -ac tree all nicely merged. I guess your definition of happening
is my definition of "happened" 8)

