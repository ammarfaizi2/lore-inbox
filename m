Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263060AbRE1Nlj>; Mon, 28 May 2001 09:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263061AbRE1Nl3>; Mon, 28 May 2001 09:41:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7698 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263060AbRE1NlS>; Mon, 28 May 2001 09:41:18 -0400
Subject: Re: Overkeen CDROM disk-change messages
To: harri@synopsys.COM (Harald Dunkel)
Date: Mon, 28 May 2001 14:38:39 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rankinc@pacbell.net (Chris Rankin),
        linux-kernel@vger.kernel.org
In-Reply-To: <3B11DB3A.E99D0895@Synopsys.COM> from "Harald Dunkel" at May 28, 2001 06:59:38 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154NEF-00037I-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If there is no CD in the drive, why are there messages in kern.log 
> about a CD change? Shouldn't it be something like 'CD drive empty'?

Because that is what the drive is reporting back to the OS
