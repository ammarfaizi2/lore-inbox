Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135558AbRDXLwA>; Tue, 24 Apr 2001 07:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135556AbRDXLvu>; Tue, 24 Apr 2001 07:51:50 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:35845 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135557AbRDXLvj>; Tue, 24 Apr 2001 07:51:39 -0400
Date: Tue, 24 Apr 2001 13:51:22 +0200 (CEST)
From: axel <axel@rayfun.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: compile error 2.4.4pre6: inconsistent operand constraints in an
In-Reply-To: <E14rpIA-0000iK-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0104241350230.8659-100000@neon.rayfun.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about correcting the needed gcc version in Documentation/Changes?

On Mon, 23 Apr 2001, Alan Cox wrote:

> > after having had trouble with compilation due to old gcc version, i have
> > updated to gcc 3.0 and received the following error:
> 
> 2.4.4pre6 only builds with gcc 2.96. If you apply the __builtin_expect fixes
> it builds and runs fine with 2.95. Not tried egcs. The gcc 3.0 asm constraints
> one I've yet to see a fix for.
> 

