Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266735AbTBGWU7>; Fri, 7 Feb 2003 17:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbTBGWU7>; Fri, 7 Feb 2003 17:20:59 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:20945 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S266735AbTBGWU7>; Fri, 7 Feb 2003 17:20:59 -0500
Date: Fri, 7 Feb 2003 22:30:38 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: syscall documentation (5 and last)
Message-ID: <20030207223038.GA8010@bjl1.jlokier.co.uk>
References: <UTC200302062012.h16KC6Z23622.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200302062012.h16KC6Z23622.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>        ARCH_SET_FS
>               Set the 64bit base for the FS register to addr.
...
>        ARCH_SET_GS
>               Set the 64bit base for the FS register to addr.
                                           ^^
I think that should be GS.

-- Jamie
