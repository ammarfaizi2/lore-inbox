Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291564AbSBHNo2>; Fri, 8 Feb 2002 08:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291571AbSBHNoS>; Fri, 8 Feb 2002 08:44:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12559 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291564AbSBHNoG>; Fri, 8 Feb 2002 08:44:06 -0500
Subject: Re: Linux 2.4.18-pre9
To: turveysp@ntlworld.com (Simon Turvey)
Date: Fri, 8 Feb 2002 13:57:11 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <002001c1b045$631ad760$030ba8c0@mistral> from "Simon Turvey" at Feb 08, 2002 02:07:40 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ZBWZ-0003mA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you tell me if the final 2.4.18 will solve the problems with recent
> binutils?  Or is the onus on the binutils maintainer to fix this?

The conclusion reached on the list was that the binutils change while suprising
and somewhat annoying is actually perfectly correct and reasonable. The kernel
should eventually work with the new binutils but its up to people with that
binutils to keep testing and chasing down remaining problems
