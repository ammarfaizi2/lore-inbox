Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbULEURE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbULEURE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 15:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbULEURE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 15:17:04 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:32412 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261376AbULEUQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 15:16:53 -0500
Date: Sun, 5 Dec 2004 21:16:52 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Miguel Angel Flores <maf@sombragris.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel development environment
Message-ID: <20041205201652.GB1159@mail.13thfloor.at>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Miguel Angel Flores <maf@sombragris.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41B1F97A.80803@sombragris.com> <1102268517.9242.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1102268517.9242.16.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2004 at 05:41:59PM +0000, Alan Cox wrote:
> On Sad, 2004-12-04 at 17:52, Miguel Angel Flores wrote:
> > My actual development environment consists in a scratch vim editor, 
> > diff, patch
> > and gcc. My question is: ¿What kind of tools use you, the kernel gurus, to
> > write and debug code? ¿It's enough with vi and gcc?
> 
> Editor, compiler and at least two PC's, and occasionally gdbstubs

although I do not consider myself a 'kernel guru' ...

cscope and ctags will help with code navigation
QEMU and UML are good choices to do kernel testing
and if necessary debugging ...

HTH,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
