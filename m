Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269313AbUIHTWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269313AbUIHTWY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 15:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269277AbUIHTWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 15:22:24 -0400
Received: from serwer.tvgawex.pl ([212.122.214.2]:53454 "HELO
	mother.localdomain") by vger.kernel.org with SMTP id S269315AbUIHTWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 15:22:22 -0400
Date: Wed, 8 Sep 2004 21:21:18 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux Routing Performance inferior?
Message-ID: <20040908192118.GH7736@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200409071000.58455.rchandar-knl@qz.port5.com> <Pine.LNX.4.58.0409081354470.2985@sparrow> <413F525E.3010408@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <413F525E.3010408@optonline.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 02:41:34PM -0400, Nathan Bryant wrote:
> >>"FreeBSD (5.x) can route 1Mpps on a 2.8G Xeon while
> >>Linux can't do much more than 100kpps"
> 
> Nonetheless, FreeBSD has some advantages. They achieved their results 
> using a fast forwarding path (enabled via sysctl) that processes 
> forwarded packets to completion entirely within the interrupt handler.

 I've already posted presentation about those features (*) to netdev.
Some ideas looks interesting enough to be implemented in Linux.

* http://people.freebsd.org/~andre/FreeBSD-5.3-Networking.pdf

-- 
Tomasz Torcz                        To co nierealne - tutaj jest normalne.
zdzichu@irc.-nie.spam-.pl          Ziomale na ¿ycie maj± tu patenty specjalne.

