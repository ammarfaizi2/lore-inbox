Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261280AbREUPZH>; Mon, 21 May 2001 11:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbREUPY5>; Mon, 21 May 2001 11:24:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28420 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261280AbREUPYt>; Mon, 21 May 2001 11:24:49 -0400
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
To: wichert@cistron.nl (Wichert Akkerman)
Date: Mon, 21 May 2001 16:21:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9ebbk7$3uq$1@picard.cistron.nl> from "Wichert Akkerman" at May 21, 2001 05:18:31 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151rV6-0000Nz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mike A. Harris <mharris@opensourceadvocate.org> wrote:
> >For the record, the kgcc "mess" you speak of was used by
> >Conectiva, and I believe also by debian
> Debian never had that mess.

Debians variant was gcc272 not kgcc. The 2.2.19 makefile knows about both of
them

