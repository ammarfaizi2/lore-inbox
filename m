Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292108AbSB0OpR>; Wed, 27 Feb 2002 09:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292535AbSB0OpH>; Wed, 27 Feb 2002 09:45:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46348 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292529AbSB0Oo7>; Wed, 27 Feb 2002 09:44:59 -0500
Subject: Re: [PATCH] Re: IDE error on 2.4.17
To: andersen@codepoet.org
Date: Wed, 27 Feb 2002 14:59:28 +0000 (GMT)
Cc: vojtech@suse.cz (Vojtech Pavlik), turveysp@ntlworld.com (Simon Turvey),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20020227102544.GA3226@codepoet.org> from "Erik Andersen" at Feb 27, 2002 03:25:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16g5YG-0004gk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Any chance it's one of those fast IBM 30 or 45 gig drives? They seem to
> > be dying pretty fast ...
> 
> I expect a patch like this would help avoid these sort of
> questions...

This is the wrong approach. That information is available properly if and
when the vendors install the smart utilities
