Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270343AbRHMR6r>; Mon, 13 Aug 2001 13:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270354AbRHMR6h>; Mon, 13 Aug 2001 13:58:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61191 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270343AbRHMR62>; Mon, 13 Aug 2001 13:58:28 -0400
Subject: Re: 2.4.8-ac2 USB keyboard capslock hang
To: braam@clusterfilesystem.com (Peter J. Braam)
Date: Mon, 13 Aug 2001 19:01:03 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        johannes@erdfelt.com (Johannes Erdfelt), linux-kernel@vger.kernel.org
In-Reply-To: <20010813115535.B1958@lustre.dyn.ca.clusterfilesystem.com> from "Peter J. Braam" at Aug 13, 2001 11:55:35 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WM1P-0007uJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Aug 13, 2001 at 06:56:48PM +0100, Alan Cox wrote:
> 
> > Roswell is the Red Hat 7.2 beta, so its probably another bug that was fixed
> > in the USB and input updates in -ac
> It hangs on 2.4.8-ac2, so was this bug fix lost perhaps? 

It would be useful to know if 2.4.7ac3 say works and if so which one after
that it broke at

