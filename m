Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272980AbRJEUZS>; Fri, 5 Oct 2001 16:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272838AbRJEUZI>; Fri, 5 Oct 2001 16:25:08 -0400
Received: from quechua.inka.de ([212.227.14.2]:12552 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S272773AbRJEUYx>;
	Fri, 5 Oct 2001 16:24:53 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?
In-Reply-To: <m1669uyuqy.fsf@frodo.biederman.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.10-xfs (i686))
Message-Id: <E15pbX5-0007do-00@calista.inka.de>
Date: Fri, 05 Oct 2001 22:25:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m1669uyuqy.fsf@frodo.biederman.org> you wrote:
> Definentily.  We want a write-barrier however we can get it.

Does that mean we can or we can't? Is there a flush write cache operation in
ATA? I asume there is one in SCSI?

Greetings
Bernd
