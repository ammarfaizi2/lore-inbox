Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279846AbRKSQJu>; Mon, 19 Nov 2001 11:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279934AbRKSQJl>; Mon, 19 Nov 2001 11:09:41 -0500
Received: from mx1out.umbc.edu ([130.85.253.51]:50080 "EHLO mx1out.umbc.edu")
	by vger.kernel.org with ESMTP id <S277012AbRKSQJ3>;
	Mon, 19 Nov 2001 11:09:29 -0500
Date: Mon, 19 Nov 2001 11:09:24 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Hp 8xxx Cd writer
In-Reply-To: <EXCH01SMTP01CJiLyNf000018e2@smtp.netcabo.pt>
Message-ID: <Pine.SGI.4.31L.02.0111191108260.12469772-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001, Miguel Maria Godinho de Matos wrote:

> I have a doubt though! I have an externel cd-writer ( hp 8200 ) which is
> supported by the kernel, but in the make xconfig menu, that options appears
> in gray ( u can't select it ). As a lot of kernel options need some kind of
> pre-selected items, i am asking anyone who  knows what do i have to
> pre-select so i can choose the module for hp..... support in my usb kernel
> configuration menu.

You probably need to say yes to experimental drivers, and if I recall the
HP8200 correctly, various USB options.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

