Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291019AbSBUMvr>; Thu, 21 Feb 2002 07:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291463AbSBUMvj>; Thu, 21 Feb 2002 07:51:39 -0500
Received: from ginsberg.uol.com.br ([200.231.206.26]:31964 "EHLO
	ginsberg.uol.com.br") by vger.kernel.org with ESMTP
	id <S291019AbSBUMv2> convert rfc822-to-8bit; Thu, 21 Feb 2002 07:51:28 -0500
Date: Thu, 21 Feb 2002 09:51:25 -0300 (BRT)
From: Cesar Suga <sartre@linuxbr.com>
To: Fernando Korndorfer <fernando@quatro.com.br>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: SMP problems
In-Reply-To: <004a01c1bad5$dd4a02a0$c50016ac@spps.com.br>
Message-ID: <Pine.LNX.4.40.0202210950140.24007-100000@sartre.linuxbr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Fernando Korndorfer wrote:

>         I'm having some problems copiling the latest kernel with SMP (and
> w/o too). If I boot a SMP-enabled kernel, the system hangs after detecting
> the second CPU. and I can't compile the kernel w/o SMP support (it causes a
> lot of 'redefinitions'...). Can anyone help me?

	Which board? Some people complained about the new AMD board (with
2 Athlons) which certainly is too new to be supported (well, Athlon SMP
support is new, at least for me).

	Regards,
	Cesar Suga <sartre@linuxbr.com>
	São Caetano do Sul/SP/Brazil


