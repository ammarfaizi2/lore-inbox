Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263421AbRFAItU>; Fri, 1 Jun 2001 04:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263423AbRFAItA>; Fri, 1 Jun 2001 04:49:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37125 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263421AbRFAIs5>; Fri, 1 Jun 2001 04:48:57 -0400
Subject: Re: [PATCH] almost forgot this one
To: thockin@sun.com (Tim Hockin)
Date: Fri, 1 Jun 2001 09:46:49 +0100 (BST)
Cc: alan@redhat.com, linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3B17000D.D6E54DA0@sun.com> from "Tim Hockin" at May 31, 2001 07:38:05 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155ka1-0000Dh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Add a rwproc entry to the ide structure, for recalling what happened last
> time!
> 
> Please let me knwo if there are any problems with this patch (some of the
> patches I sent earlier depend on this).

Looks ok to me, but check with Andre
