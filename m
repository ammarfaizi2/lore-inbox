Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132739AbRDQQDC>; Tue, 17 Apr 2001 12:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132736AbRDQQCm>; Tue, 17 Apr 2001 12:02:42 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30735 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132734AbRDQQCb>; Tue, 17 Apr 2001 12:02:31 -0400
Subject: Re: Possible problem with zero-copy TCP and sendfile()
To: kas@informatics.muni.cz (Jan Kasprzak)
Date: Tue, 17 Apr 2001 17:04:13 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010417170206.C2589096@informatics.muni.cz> from "Jan Kasprzak" at Apr 17, 2001 05:02:06 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pXxg-0002cI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> : but once a fixed BIOS is out for your board that would be a good first step.
> : If it still does it then, its worth digging for kernel naughties
> : 
> 	I don't think I have 686b southbridge. I have 686 (without "b"):

Ok. What revision of 3c90x card do you have ?

