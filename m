Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279227AbRJ2Lgd>; Mon, 29 Oct 2001 06:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279233AbRJ2LgX>; Mon, 29 Oct 2001 06:36:23 -0500
Received: from erasmus.jurri.net ([62.236.96.196]:10940 "EHLO
	oberon.erasmus.jurri.net") by vger.kernel.org with ESMTP
	id <S279227AbRJ2LgT>; Mon, 29 Oct 2001 06:36:19 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.13-acX: NM256 hangs at boot
In-Reply-To: <87y9luohi8.fsf@puck.erasmus.jurri.net>
	<3BDD34D3.B7ABE033@mandrakesoft.com>
From: Samuli Suonpaa <suonpaa@iki.fi>
Date: 29 Oct 2001 13:36:41 +0200
In-Reply-To: <3BDD34D3.B7ABE033@mandrakesoft.com>
Message-ID: <871yjmd6eu.fsf@puck.erasmus.jurri.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> Does backing out this patch fix things?
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.4.13/nm256-ac97-update-2.4.13.ac1.patch.gz

Yes it did, thanks.

Unfortunately I do not have the skills to debug your patch but should
you have anything you'd like me to test, I'll be more than happy to do
it.

Suonp‰‰...
