Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292890AbSCISop>; Sat, 9 Mar 2002 13:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292891AbSCISof>; Sat, 9 Mar 2002 13:44:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29449 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292890AbSCISoX>; Sat, 9 Mar 2002 13:44:23 -0500
Subject: Re: Pentium mobo fails on upgrade from 2.2 to 2.4
To: amon@vnl.com (Dale Amon)
Date: Sat, 9 Mar 2002 18:59:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020309134540.GZ13355@vnl.com> from "Dale Amon" at Mar 09, 2002 01:45:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jm3j-0002Ew-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Advice on how to proceed would be much welcome. I've
> run across some hard cases over the years, but at least
> they gave me something to go on.

kdb is probably your best bet. Serial console might actually reveal stuff
too. Also ensure you have APM off and see what occurs if you use mem=16M
