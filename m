Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129065AbRBMUg3>; Tue, 13 Feb 2001 15:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129160AbRBMUgT>; Tue, 13 Feb 2001 15:36:19 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:2824 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129065AbRBMUgF>; Tue, 13 Feb 2001 15:36:05 -0500
Date: Tue, 13 Feb 2001 12:35:57 -0800
Message-Id: <200102132035.f1DKZvd01743@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Michèl Alexandre Salim <salimma1@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI GART (?)
In-Reply-To: <20010213120932.8110.qmail@web3502.mail.yahoo.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001 12:09:32 +0000 (GMT), Michèl Alexandre Salim <salimma1@yahoo.co.uk> wrote:

> Currently running the XFree 4.0.2 from RH 7.0.90 (7.1
> beta, Fisher) on top of my RH 7 + Ximian system and
> when using aviplay it doesn't use any acceleration
> features at all, consequently choppy display. The same
> file plays much better in Windows.

Get the XFree ati.2 drivers from http://www.linuxvideo.org/gatos/,
and you will have hardware scaling. DRI is not supported yet.

> Xdpyinfo shows that Xvideo and Xrender are both
> loaded, so I presume they *should* work.

xvinfo is a bit more informative about these things.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
