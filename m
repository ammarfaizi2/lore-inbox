Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311642AbSDCVRB>; Wed, 3 Apr 2002 16:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311786AbSDCVQv>; Wed, 3 Apr 2002 16:16:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28422 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311642AbSDCVQp>; Wed, 3 Apr 2002 16:16:45 -0500
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
To: davids@webmaster.com (David Schwartz)
Date: Wed, 3 Apr 2002 22:33:18 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, andrea@suse.de (Andrea Arcangeli),
        linux-kernel@vger.kernel.org, arjanv@redhat.com (Arjan van de Ven),
        hugh@veritas.com (Hugh Dickins), mingo@redhat.com (Ingo Molnar),
        stelian.pop@fr.alcove.com (Stelian Pop)
In-Reply-To: <20020403210754.AAA22091@shell.webmaster.com@whenever> from "David Schwartz" at Apr 03, 2002 01:07:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ssNa-0004ZV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> allow other people to use and modify it. You can't have it both ways -- 
> there's no such thing as 'GPL but with a few extra restrictions I've added to 
> the code that everyone's contributed to'.

Nor is there "GPL with a few things ignored". 
