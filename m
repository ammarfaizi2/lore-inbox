Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282579AbRKZVfL>; Mon, 26 Nov 2001 16:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282580AbRKZVfD>; Mon, 26 Nov 2001 16:35:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62982 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282579AbRKZVet>; Mon, 26 Nov 2001 16:34:49 -0500
Subject: Re: Async UDP I/O?
To: braymond@fvc.com (Brian Raymond)
Date: Mon, 26 Nov 2001 21:43:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <6A5AF4EA59EB214BB0267741CE2C86EF0E07F5@neptune.cuseeme.com> from "Brian Raymond" at Nov 26, 2001 04:07:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E168TX1-00070O-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> regard to async UDP traffic but haven't had much luck so I thought I would
> throw this out to the list.

What do you mean by "asynchronous UDP" - all UDP is asynchronous. You ask
it to send it and it gets queued or dropped somewhere - its not subject
to flow control like TCP

Can you explain more ?

Alan
