Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273854AbRJ3MnF>; Tue, 30 Oct 2001 07:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273870AbRJ3Mmy>; Tue, 30 Oct 2001 07:42:54 -0500
Received: from bugs.unl.edu.ar ([168.96.132.208]:4232 "HELO bugs.unl.edu.ar")
	by vger.kernel.org with SMTP id <S273854AbRJ3Mml>;
	Tue, 30 Oct 2001 07:42:41 -0500
Content-Type: text/plain;
  charset="iso-8859-2"
From: =?iso-8859-2?q?Mart=EDn=20Marqu=E9s?= <martin@bugs.unl.edu.ar>
To: "Terry Kendal" <kewl@compfort.pl>, <linux-kernel@vger.kernel.org>
Subject: Re: no shared memory?
Date: Tue, 30 Oct 2001 09:41:55 -0300
X-Mailer: KMail [version 1.3]
In-Reply-To: <001901c1613f$9b8bf840$6f00000a@compfort>
In-Reply-To: <001901c1613f$9b8bf840$6f00000a@compfort>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011030124158.A32E72AB4A@bugs.unl.edu.ar>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 30 Oct 2001 09:37, Terry Kendal wrote:
> hello,
>
> after upgrading my computer to newer distro with kernel series 2.4 ive
> found something i have question about
> issuing free or top commands shows 0kb of shared memory
>
> how is that possible ?
> i have apache and mysql running, thought they'd use shared memory?

Use 'ipcs' for searching shared memory and semaphores of aplications.

> i recompiled procps package with no effect
>
> can someone please xplain it to me ?

It seems dificult to calculate the amount of shared memory used, and for what 
I know, useless.
Anyway, I heard that Alan Cox's release of 2.4.13 has some code to show the 
shared memory used, but only the one used my applications.

Saludos... :-)

-- 
Porqué usar una base de datos relacional cualquiera,
si podés usar PostgreSQL?
-----------------------------------------------------------------
Martín Marqués                  |        mmarques@unl.edu.ar
Programador, Administrador, DBA |       Centro de Telematica
                       Universidad Nacional
                            del Litoral
-----------------------------------------------------------------
