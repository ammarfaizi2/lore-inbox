Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135190AbRALUj5>; Fri, 12 Jan 2001 15:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133012AbRALUjr>; Fri, 12 Jan 2001 15:39:47 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:8240 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S132554AbRALUjg>; Fri, 12 Jan 2001 15:39:36 -0500
Date: Fri, 12 Jan 2001 15:39:35 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
In-Reply-To: <20010112195715.A30496@athlon.random>
Message-ID: <Pine.LNX.4.10.10101121537140.24575-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This way we are 100% consistent and we don't lose the "cpu_has" information.

but /dev/cpu/*/{msr|cpuid} are "cpu has".

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
