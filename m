Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286339AbSA2XRO>; Tue, 29 Jan 2002 18:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286821AbSA2XPx>; Tue, 29 Jan 2002 18:15:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65033 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286756AbSA2XOm>; Tue, 29 Jan 2002 18:14:42 -0500
Subject: Re: Linux 2.4.18pre7-ac1
To: kristian.peters@korseby.net (Kristian)
Date: Tue, 29 Jan 2002 23:27:23 +0000 (GMT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020129221545.4e9a253e.kristian.peters@korseby.net> from "Kristian" at Jan 29, 2002 10:15:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Vhet-0005Ut-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Compiling fails with the following output:
> 
> ld: cannot open ipt_ah.o: No such file or directory

Thats a bug in the base 2.4.18pre7

> Maybe that was meant with
> > several 18pre7 netfilter bugs left unfixed for now

Yep 
