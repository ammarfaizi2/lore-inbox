Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280658AbRKBLzt>; Fri, 2 Nov 2001 06:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280661AbRKBLz3>; Fri, 2 Nov 2001 06:55:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19716 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280658AbRKBLzX>; Fri, 2 Nov 2001 06:55:23 -0500
Subject: Re: 3.0.2 fails to build linux-2.4.13-ac5, 8139.c
To: _deepfire@mail.ru (Samium Gromoff)
Date: Fri, 2 Nov 2001 12:02:00 +0000 (GMT)
Cc: gcc-bugs@gcc.gnu.org, linux-kernel@vger.kernel.org
In-Reply-To: <200111020921.fA29LP718803@vegae.deep.net> from "Samium Gromoff" at Nov 02, 2001 12:21:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15zd1M-00024u-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 8139too.c:2432: Internal compiler error in reload_cse_simplify_operands, at reload1.c:8364
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.

You reported the bug to the wrong place. Its a compiler bug not a kernel
bug. See the URL given for gcc bug reporting info

