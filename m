Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289540AbSAVXQY>; Tue, 22 Jan 2002 18:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289541AbSAVXQO>; Tue, 22 Jan 2002 18:16:14 -0500
Received: from hermes.cicese.mx ([158.97.1.34]:27875 "EHLO hermes.cicese.mx")
	by vger.kernel.org with ESMTP id <S289540AbSAVXQE>;
	Tue, 22 Jan 2002 18:16:04 -0500
Message-ID: <3C4DF2AD.66BC3F6C@cicese.mx>
Date: Tue, 22 Jan 2002 15:15:57 -0800
From: Serguei Miridonov <mirsev@cicese.mx>
Organization: CICESE Research Center, Ensenada, B.C., Mexico
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Console output for debugging
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Q: Is there any function in the kernel which I can call
safely from a module to print debug message on the console
screen?

I don't want to use printk for some reasons. One of them is
that I want messages to appear on the screen immediately,
even from interrupt processing routines. Another is to be
able to see messages until the system freezes completely in
case of software or hardware bug.

Thank you.


--
Serguei Miridonov                CICESE, Research Center,
CICESE, Optics Dept.             Ensenada B.C., Mexico
PO Box 434944                    E-mail: mirsev@cicese.mx
San Diego, CA 92143-4944         FAX: +52 (646) 1750553
U.S.A.



