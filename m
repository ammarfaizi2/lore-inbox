Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSCSSMY>; Tue, 19 Mar 2002 13:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288830AbSCSSMG>; Tue, 19 Mar 2002 13:12:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24077 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287862AbSCSSLz>; Tue, 19 Mar 2002 13:11:55 -0500
Subject: Re: Linux 2.4.19-pre3-ac1
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Tue, 19 Mar 2002 18:26:09 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        zwane@linux.realnet.co.sz (Zwane Mwaikambo),
        MrChuoi@yahoo.com (MrChuoi),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <20020319180417.GP2254@matchmail.com> from "Mike Fedyk" at Mar 19, 2002 10:04:17 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nOJF-0008Le-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any way (I don't thing so, but...) that KDE can affect this when
> there aren't any KDE processes running?

Please try -ac2. It seems KDE just happens to be one of the triggers for
a bug where someone mremaps a partial vma larger and moves it.

