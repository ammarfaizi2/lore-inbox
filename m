Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278658AbRJZPwG>; Fri, 26 Oct 2001 11:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278675AbRJZPv5>; Fri, 26 Oct 2001 11:51:57 -0400
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:6787 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S278658AbRJZPvr>; Fri, 26 Oct 2001 11:51:47 -0400
Message-ID: <3BD9867D.382CCC36@cisco.com>
Date: Fri, 26 Oct 2001 21:21:25 +0530
From: Manik Raina <manik@cisco.com>
Organization: Cisco Systems Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: linux-kernel@vger.kernel.org, azu@sysgo.de
Subject: Re: [PATCH] : preventing multiple includes of the same header file
In-Reply-To: <Pine.GSO.4.33.0110231618100.29108-100000@cbin2-view1.cisco.com> <20011023080936.A13088@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've changed _PPC_xxx_H to _ASM_xxx_H to match the rest of the headers.
> This is now in the PPC bk tree, and will eventually hit Linus' tree,
> thanks!
>

Would point your kind attention towards some others files in the same
directory
(include/asm-ppc) which dont follow _PPC_XXX_H convention either.....

residual.h
rxplite.h
rpxhiox.h

and a few more ....

thanks
Manik



