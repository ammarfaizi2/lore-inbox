Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264525AbRFOV25>; Fri, 15 Jun 2001 17:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264529AbRFOV2r>; Fri, 15 Jun 2001 17:28:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22792 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264525AbRFOV2i>; Fri, 15 Jun 2001 17:28:38 -0400
Subject: Re: Kernel 2.0.35 limits
To: paul@engsoc.org (Paul Faure)
Date: Fri, 15 Jun 2001 22:27:35 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106151702300.22155-100000@stout.engsoc.carleton.ca> from "Paul Faure" at Jun 15, 2001 05:23:16 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15B17v-000790-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just this morning, our firewall get a kernel panic after 500 days of
> uptime.

Interesting very interesting in fact. There is a 497 day wrap on the kernel but
it should do nothing more than send the uptime back to zero. Im not sure
how the crash fits in to this but it could be significant that its about
the wrap time

