Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293412AbSCARUl>; Fri, 1 Mar 2002 12:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293416AbSCARUc>; Fri, 1 Mar 2002 12:20:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63239 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293412AbSCARUS>; Fri, 1 Mar 2002 12:20:18 -0500
Subject: Re: [PATCH] bluesmoke/MCE support optional
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Fri, 1 Mar 2002 17:29:23 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mfedyk@matchmail.com (Mike Fedyk),
        p_gortmaker@yahoo.com (Paul Gortmaker), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0203011210300.2391-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Mar 01, 2002 12:10:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gqqR-0004KQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On a pentium box with the newer MCE setup code you must force MCE on.
> And if you don't ? 

The processor runs with MCE disabled and works as it did before MCE went in
- ie no reporting over l1 cache failure etc, but equally 100% compatibility
