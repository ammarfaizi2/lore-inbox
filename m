Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132223AbRAGOdh>; Sun, 7 Jan 2001 09:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132605AbRAGOd2>; Sun, 7 Jan 2001 09:33:28 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:18828 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S132223AbRAGOdW>; Sun, 7 Jan 2001 09:33:22 -0500
Date: Sun, 7 Jan 2001 15:33:48 +0100 (CET)
From: Matthias Juchem <matthias@gandalf.math.uni-mannheim.de>
Reply-To: Matthias Juchem <juchem@uni-mannheim.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new bug report script
In-Reply-To: <E14FGfM-0002jO-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0101071523090.7104-100000@gandalf.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, Alan Cox wrote:

> None of these are needed for normal build/use/bug reporting work. In fact
> if you look at script_asm you'll see we go to great pains to ship prebuilt
> files too

Well, DocBook documentation isn't need for normal builds either and has
jade as dependency - something that can less often be found on GNU/Linux
in my opinion.
Why can't I assume that perl is installed? It can be found on every
standard Linux/Unix installation.
And besides, the bug report script doesn't replace anything the doesn't
need perl - ver_linux, REPORTING-BUGS and oops-tracing.txt are still there
for the more advanced user.
My script is intended for the one who likes to provide bug reports but is
too lazy to look up all the information or simply is not sure about what
to include.
Starting with my script to generate their reports, the users can customize
the reports and also write them by hand if they feel like doing so.

Matthias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
