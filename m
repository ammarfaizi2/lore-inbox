Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291426AbSBSOg1>; Tue, 19 Feb 2002 09:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291434AbSBSOgW>; Tue, 19 Feb 2002 09:36:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43534 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291426AbSBSOf1>; Tue, 19 Feb 2002 09:35:27 -0500
Subject: Re: 2.4.18-pre9-ac4 filesystem corruption
To: kristian.peters@korseby.net (Kristian)
Date: Tue, 19 Feb 2002 14:49:43 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        andre@linux-ide.org
In-Reply-To: <20020219153248.39a1b7fc.kristian.peters@korseby.net> from "Kristian" at Feb 19, 2002 03:32:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dBaR-0000fj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> memtest86 completed successfully.
> I'll test with -rc2-ac1 for ext2 corruption again.

Thanks. If you do see it can you test with ide=nodma as well and see what
that does. Andre will probably also want to know how long your IDE cables
are 8)
