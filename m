Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133013AbRDUXHy>; Sat, 21 Apr 2001 19:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133019AbRDUXHf>; Sat, 21 Apr 2001 19:07:35 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32781 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133013AbRDUXH3>; Sat, 21 Apr 2001 19:07:29 -0400
Subject: Re: Request for comment -- a better attribution system
To: esr@thyrsus.com
Date: Sun, 22 Apr 2001 00:09:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (CML2), kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010421114942.A26415@thyrsus.com> from "Eric S. Raymond" at Apr 21, 2001 11:49:42 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14r6V4-0004XB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> any given piece of code to identify the responsible maintainer.  The motivation
> for this proposal is that the present system, a single top-level MAINTAINERS
> file, doesn't seem to be scaling well.

It scales perfectly. Most of the people you annoyed are _in_ the maintainers
and credits file. The fundamental problem is identical regardless of what
you change - people forget to update things unless there is motivation [1]

Alan
[1] as proof of this claim count the number of CREDIT file updates made shortly
after the RH share offering..

